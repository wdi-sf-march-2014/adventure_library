class PagesController < ApplicationController
	before_filter :load_adventure

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
    if @page.save
      redirect_to adventure_pages_path(@adventure)
    else
      render 'new'
    end
  end

  def destroy
    @page = @adventure.pages.find(params[:id])
    @page.destroy
    redirect_to adventure_pages_path(@adventure)
  end

  private
  def page_params
    params.require(:page).permit(:name, :text)
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
  end
end
