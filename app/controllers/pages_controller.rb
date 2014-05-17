class PagesController < ApplicationController
include PagesHelper
before_action :load_adventure

  def index
    @page = @adventure.pages.all
  end

  def show
    @page = @adventure.pages.find(params[:id])
  end

  def create
    @page = @adventure.pages.new(pages_params)
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

  def new
    @page = @adventure.pages.new
  end

  def start
    @adventure = Adventure.find(params[:id])
    @start = @adventure.pages.find_by(name: "start").id
    redirect_to new_adventure_page_path(@adventure, @start)
  end

  private
    def load_adventure
      @adventure = Adventure.find(params[:adventure_id])
    end

    def pages_params
      params.require(:page).permit(:name, :text)
    end
end
