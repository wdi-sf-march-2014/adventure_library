class AdventuresWorker
  include Sidekiq::Worker
  # sidekiq_options retry: false
  
  def perform(library_id)
    library = Library.find(library_id)
    response = Typhoeus.get("#{library.url}/adventures.json")  
    @adventures = JSON.parse(response.body)
    @adventures['adventures'].each do |adv|
      #if adv.find_by(guid: adv['guid'])
      #else
        Adventure.create(guid: adv['guid'], title: adv['title'], author: adv['author'])
      #end
    end
  end
end


#library.
#, :pages_attributes => adv[:pages]

# def perform(library_id)
#     library = Library.find(library_id)
#     response = Typhoeus.get("#{library.url}/libraries.json")  
#     @libraries = JSON.parse(response.body)
    
#     @libraries['libraries'].each do |l|
#       if Library.find_by(url: l['url'])
#       else
#         Library.create(url: l['url'])
#       end
#       AdventuresWorker.perform_async(l['id'])
#     end
#   end
# end