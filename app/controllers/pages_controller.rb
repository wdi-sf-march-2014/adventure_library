class PagesController < ApplicationController
 include PagesHelper
 before_action :load_adventure

	def index
		@pages = @adventure.pages
	end

	def show
		@pages = @adventure.page.find(params[:id])
	end

	def new
		@page = @adventure.pages.new
	end

	def create
		@page = @adventure.pages.new(page_params)
		@page.adventure_id = @adventure.id
		if @page.save
			if @page.name == "end"
				redirect_to root_path
			else
				redirect_to new_adventure_page_path(@adventure)
			end
		else
			flash[:errors] = @page.errors.full_messages
			render :new
		end
	end

	def show
		@start = @adventure.pages.find_by(name: "start").id
		@page = @adventure.pages.find(@start)
		@next = @start.to_i + 1


	end

	private
		def page_params
			params.require(:page).permit(:name, :text)
		end

		def load_adventure
			@adventure = Adventure.find(params[:adventure_id])
		end
end
