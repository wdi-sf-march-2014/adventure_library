class AdventureWorker
	include Sidekiq::Worker

	#scrapes library (second layer)
	def scrape_adv(library)
		libraries = Library.all
		libraries.each do |l|
			response = Typhoeus.get("#{library.url}/adventures.json")
			result = JSON.parse(response.body)
			result['adventures'].each do |a|   
			adventure = Adventure.create!(title: a["title"], author: a["author"], guid: a["guid"], library_id: a["library_id"])
				a['pages'].each do |p|
	      adventure.pages.create(name: p["name"], text: p["text"])
	    	end
			end
		end
	end

	def perform(library)   #perform is the default method for workers, railscast; performs "job" in the background
		scrape_adv(library)
	end




end