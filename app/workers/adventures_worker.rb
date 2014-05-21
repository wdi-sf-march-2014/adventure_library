class AdventuresWorker
  include Sidekiq::Worker

def perform(library_id)
  library = Library.find(library_id)
  response = Typhoeus.get("#{library.url}/adventures.json")
  result = JSON.parse(response.body)
  result["adventures"].each do |adventure|
    scraped_adventure = library.adventures.create!(:title => adventure["title"], :author => adventure["author"], :GUID => adventure["GUID"])
    adventure["pages"].each do |page|
      scraped_page = scraped_adventure.pages.create!(:name => page["name"], :text => page["text"])
    end
  end
end

end