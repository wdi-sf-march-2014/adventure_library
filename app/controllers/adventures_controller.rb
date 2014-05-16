class AdventuresController < ApplicationController

	def index
		@adventures = Adventure.all

	end
## When the user hits submit on 'add a library' in the index, they should call the scraped libraries method.
## This should be in the libraries_controller

# 	def scraped_libraries
# 		@url = params[:url]
# 		response = Typhoeus.get("#{@url}/libraries")
# binding.pry
# 		@scraped = JSON.parse(response.body)
# 	end

	def new
		@adventure = Adventure.new
	end

	def create
		@adventure = Adventure.new(adventure_params)
		@adventure.guid = SecureRandom.urlsafe_base64(10)
		@adventure.save
		redirect_to adventure_path(@adventure)
	end

	private
		def adventure_params
			params.require(:adventure).permit(:title, :author)
		end
end
