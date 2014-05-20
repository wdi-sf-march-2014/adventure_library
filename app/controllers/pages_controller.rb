class PagesController < ApplicationController
 include PagesHelper
 before_action :load_adventure

	def index
		@pages = @adventure.pages.all
	end

	def show
		@page = @adventure.pages.find(params[:id])
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

	private
		def page_params
			params.require(:page).permit(:name, :text)
		end

		def load_adventure
			@adventure = Adventure.find(params[:adventure_id])
			redirect_to root_path if @adventure.blank?
		end
end
