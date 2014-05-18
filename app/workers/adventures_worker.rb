class AdventuresWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  
  def perform(library_id)
    library = Library.find(library_id)
    response = Typhoeus.get("#{library.url}/adventures.json")  
    @adventures = JSON.parse(response.body)
    @adventures['adventures'].each do |adv|
      if Adventure.find_by(guid: adv['guid'])
      else
        library.adventures.create(guid: adv['guid'], title: adv['title'], author: adv['author'], :pages_attributes => adv[:pages])
      end
    end
  end
end

