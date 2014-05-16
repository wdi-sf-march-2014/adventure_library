class AdventuresController < ApplicationController

	def index
		@adventures = Adventure.all
	end

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
