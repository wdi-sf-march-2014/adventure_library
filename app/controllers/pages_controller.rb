class PagesController < ApplicationController
 include PagesHelper
 before_action :load_adventure
 
	def new
		@page = Page.new
	end

	def create
		@page = @adventure.page.new(page_params)
		@page.adventure_id = @adventure.id
		if @adventure.pages.all == nil
			@page.name = "start"
		else
		@page.save
		end
	end

	def show
		@page = @adventure.pages.find(params[:id])
		# @page = Page.find(params[:id])


	end

	private
		def page_params
			params.require(:page).permit(:name, :text)
		end

		def load_adventure
			@adventure = Adventure.find(params[:adventure_id])
		end
end
