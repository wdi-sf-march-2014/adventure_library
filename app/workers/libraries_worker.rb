class LibrariesWorker
   include Sidekiq::Worker
   include LibrariesHelper
 
  def perform(library_id)
    library = Library.find(library_id)
    scrape(library.url)

    @outside_libraries.each do |lib|
      clean_url = url_cleanup(lib["url"])
      unless Library.find_by(url: clean_url)
        library = Library.create(url: clean_url)
        perform(library.id)
        end
      end

    @outside_adventures.each do |adventure|
      new_adventure = {title: adventure["title"], author: adventure["author"], guid: adventure["guid"]}
      unless Adventure.find_by(guid: adventure["guid"])
        this_adventure = library.adventures.create(new_adventure)
        adventure["pages"].each do |page|
          new_page = {name: page["name"], text: page["text"]}
          this_adventure.pages.create(new_page)
        end
      end
    end
    
  end
end

# class LibrariesWorker
#   include Sidekiq::Worker
 
#   def perform(url)
#     # check if url is in library

#     #  If it is not in the library, save it

#     # Get the url/libraries.json

#     # parse results

#     # for each result
#        #  put library into db if it's not already in the database
#        #  call adventure worker

#     #  end
