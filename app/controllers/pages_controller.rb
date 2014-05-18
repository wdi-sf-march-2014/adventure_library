class PagesController < ApplicationController
	include PagesHelper

	def show
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.find(params[:id])
		@page2 = linkify_page(@page) ##not turning into links
	end

	def create
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.create(page_params)
	end

	def link1
	end

	def link2
	end

	def update
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.find(params[:id])
		@page.update_attributes(page_params)
	end

	def destroy
	end
	
  private
  	def page_params
  		params.require(:adventure[:pages_attributes]).permit(:name, :text)
  	end
end
