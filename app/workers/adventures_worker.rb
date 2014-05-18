class AdventuresWorker
  include Sidekiq::Worker

  def perform(lib_id)
    lib = Library.find(lib_id)
    adventure_parse = JSON.parse(Typhoeus.get(lib.url + "adventures.json").body)
    if adventure_parse.is_a?(Hash)
      adventure_parse["adventures"].each do |adventure| #if adventure_parse is a hash, adventures_parse["adventures"] is an array with each |adventure| a single one.
        if adventure["pages"] != nil
          if Adventure.where(["guid = ?", adventure["guid"]]).empty? == true && adventure["pages"].find { |h| h["name"] == "start" } != nil && adventure["pages"].find { |h| h["name"] == "end" } != nil
            save_adventure = lib.adventures.create(guid: adventure["guid"], title: adventure["title"], author: adventure["author"]) #library_id: lib.id
            adventure["pages"].each do |page| #each page is a hash, #adventure["pages"] is an array
              save_adventure.pages.create(name: page["name"], text: page["text"]) #adventure_id: save_adventure.id
            end
          end
        end
      end
    elsif adventure_parse.is_a?(Array)
      adventure_parse.each do |adventure| #in this case adventure_parse is an array
        if adventure["pages"] != nil
          if Adventure.where(["guid = ?", adventure["guid"]]).empty? == true && adventure["pages"].find { |h| h["name"] == "start" } != nil && adventure["pages"].find { |h| h["name"] == "end" } != nil
            save_adventure = lib.adventures.create(guid: adventure["guid"], title: adventure["title"], author: adventure["author"])
            adventure["pages"].each do |page|
              save_adventure.pages.create(name: page["name"], text: page["text"])
            end
          end
        end
      end
    end
  end
end