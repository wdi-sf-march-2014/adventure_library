class PagesController < ApplicationController
	include PagesHelper

	def show
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.find(params[:id])
	end

	def create
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.create(page_params)
	end

	def update
		@adventure = Adventure.find(params[:adventure_id])
		@page = @adventure.pages.find(params[:id])
		@page.update_attributes(page_params)
	end
	
  private
  	def page_params
  		params.require(:adventure[:pages_attributes]).permit(:name, :text)
  	end
end
