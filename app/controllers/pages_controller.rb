class PagesController < ApplicationController
  include PagesHelper
  before_action :load_adventure

  def index
    @pages = @adventure.pages.all
    load_adventure
  end

  def show
    load_page
  end

  def new
    load_adventure
    @page = @adventure.pages.build
  end

  def create
    load_adventure
    # @page = Page.create(page_params)
    @page = @adventure.pages.create page_params
    redirect_to root_path
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
    redirect_to root_path if @adventure.blank?
  end


  def load_page
    @page = @adventure.pages.find(params[:id])
    redirect_to root_path if @page.blank?
  end

  private
  def page_params
    params.require(:page).permit(:name, :text, :adventure_attributes=>[:adventure_id])
  end

end
