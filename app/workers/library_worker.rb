class LibraryWorker
	include Sidekiq::Worker

	#scrapes library (second layer)
	def scrape_lib(library)  
		response = Typhoeus.get("#{library.url}/libraries.json")
		# response = Typhoeus.get('adventures-with-raphael.herokuapp.com/libraries.json')
		result = JSON.parse(response.body)
		result['libraries'].each do |l|   
			@library = Library.new
			@library.url = l['url']
			@library.save
		end
	end

	def perform(library)   #perform is the default method for workers, railscast; performs "job" in the background
		scrape_lib(library)
	end




end
