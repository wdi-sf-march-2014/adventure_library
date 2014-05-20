class LibrariesWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform(library_id)
		library = Library.find(library_id)
		response = Typhoeus.get("#{library.url}/libraries.json")
		@libraries = JSON.parse(response.body)
		@libraries['libraries'].each do |l|
			library = Library.find_by(url: l['url'])
			if !library
				library = Library.create(url: l['url'])
			end
			
			AdventuresWorker.new.perform(library.id)
		end
	end
end

