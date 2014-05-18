# adventure_worker.rb

class AdventuresWorker
  include Sidekiq::Worker

def get_adventures id
    library = Library.find(id)
    if library
      request = Typhoeus.get(library.url+"/adventures.json")
      result = JSON.parse(request.body)

      if result
        result['adventures'].each do |adventure|
          existing_story = Adventure.find_by(guid: adventure.guid)
          if existing_story
            existing_story.update_attributes(adventure)
          else
            library.adventures.create(adventure)
          end
        end
      end
    end
end

end