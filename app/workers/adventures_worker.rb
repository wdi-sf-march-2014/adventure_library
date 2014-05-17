class AdventuresWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  
  def perform(library_id)
    library = Library.find(library_id)
    response = Typhoeus.get("#{library.url}/adventures.json")  
    @adventures = JSON.parse(response.body)
    @adventures['adventures'].each do |g|
    if Adventure.find_by(guid: g['guid']).exists?
    else
      Adventure.create(guid: g['guid'], title: g['title'], author: g['author'])
    end
  end
end

