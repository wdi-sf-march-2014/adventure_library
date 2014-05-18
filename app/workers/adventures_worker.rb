class AdventuresWorker
  include Sidekiq::Worker

  def perform(lib)
    adventure_response = Typhoeus.get(lib.url + "adventures.json")
    adventure_parse = JSON.parse(adventure_response.body)
    if adventure_parse.is_a?(Hash)
      adventures = adventure_parse["adventures"] #adventures is an array
      adventures.each do |adventure| #each adventure is a hash
        if adventure["pages"] != nil
          if Adventure.where(["guid = ?", adventure["guid"]]).empty? == true && adventure["pages"].find { |h| h["name"] == "start" } != nil
            save_adventure = lib.adventures.create(guid: adventure["guid"], title: adventure["title"], author: adventure["author"]) #library_id: lib.id
            adventure["pages"].each do |page| #each page is a hash, #adventure["pages"] is an array
              save_adventure.pages.create(name: page["name"], text: page[:text]) #adventure_id: save_adventure.id
            end
          end
        end
      end
    end
  end
end