class AdventuresWorker
  include Sidekiq::Worker
  # notes from steven use the following
  # include Sidetiq::Schedulable
  # recurrence { daily }
  def perform(library_id)
  library = Library.find(library_id)
   response = Typhoeus.get("#{library.url}/libraries.json")
   result = JSON.parse(response.body)
   result["libraries"].each do |url_link|
    if Library.find_by_url(url_link["url"])
      else
      @library = Library.new
      @library.url = url_link["url"]
      @library.save 
      response = Typhoeus.get("#{@library.url}/adventures.json")
      result = JSON.parse(response.body)
      result["adventures"].each do |adventure|
        if Adventure.find_by_guid(adventure["guid"])
          else
           local_adventure = Adventure.create!(title: adventure["title"], author: adventure["author"], guid: adventure["guid"], library_id: @library.id)
           adventure["pages"].each do |page|
           local_adventure.pages.create!(name: page["name"], text: page["text"])
           end #ends if Adventure
        end #ends result["adventures"]
      end 
    end
  end
end


end