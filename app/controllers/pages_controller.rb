class PagesController < ApplicationController
	def index
		@pages = Page.all
	end

	def new
		@page = Page.new
	end

	def create
		@page = Page.new(page_params)
		@page.save
	end

	private
		def page_params
			params.require(:page).permit(:name, :text)
		end
end
