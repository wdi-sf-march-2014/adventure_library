class LibrariesWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  
  def perform(library_id)
    library = Library.find(library_id)
    response = Typhoeus.get("#{library.url}/libraries.json")  
    @libraries = JSON.parse(response.body)
    
    @libraries['libraries'].each do |l|
      Library.create(url: l['url'])
    end

  end
end
