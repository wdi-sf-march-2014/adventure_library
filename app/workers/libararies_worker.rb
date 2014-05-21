# library_worker.rb
class LibrariesWorker
  include Sidekiq::Worker
  sidekiq_options retry: flase

  def perform(Library_id)

    library = Library.find(library_id)
    response = Typhoeus.get(url+"/libraries.json")
    @libraries = JSON.parse(response.body)

    
    @libraries['libraries'].each do |l|
      Library.create(url:l['url']) 
    end

  end

end
AdventuresWorker.new.perform(2)