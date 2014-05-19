class LibrariesWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(url)

    #take action only if library is not yet in DB
    if !Library.where(url: url).exists?
      
      #add to DB
      library = Library.create(url: url)

      #send to adventures_worker
      AdventuresWorker.perform_async(library.id)

      #request any other libraries known
      lib_json = Typhoeus.get(url+'/libraries.json')
      lib = JSON.parse(lib_json.body)
      libraries = lib["libraries"]

      #run this libraries_worker on each of those urls
      libraries.each do |library|
        new_url = library["url"]
        LibrariesWorker.perform_async(new_url)
      end

  	end
  end
end
