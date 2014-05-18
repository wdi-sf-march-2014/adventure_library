class Library_Worker
	include Sidekiq::Worker

	def scrape_lib(library)
		response = Typhoeus.get("#{library.url}/libraries.json")
		# response = Typhoeus.get('adventures-with-raphael.herokuapp.com/libraries.json')
		result = JSON.parse(response.body)
		result['libraries'].each do |l|   ##rails c (SE)
			@library = Library.new
			@library.url = l['url']
			@library.save
		end
	end

	def scrape_adv(library)
		response = Typhoeus.get("#{library.url}/adventures.json")
		# response = Typhoeus.get('adventures-with-raphael.herokuapp.com/libraries.json')
		result = JSON.parse(response.body)
		result['adventures'].each do |a|   ##rails c (SE)
			scrape_adventure = Adventure.create!(title: a["title"], author: a["author"], guid: a["guid"])
				a['pages'].each do |p|
	      scrape_adventure.pages.create!(name: p["name"], text: p["text"])
	    	end
		end
	end


	def perform   #perform is the default method for workers, railscast; performs "job" in the background
		scrape_lib(@library)
		scrape_adv(@library)
	end


end
