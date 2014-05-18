class PagesController < ApplicationController
  include PagesHelper
  before_action :load_adventure

  def index
    @pages = @adventure.pages.all
    load_adventure
  end

  def show
    @pages = @adventure.pages.find_by_name("start")
    @adventure = Adventure.find(params[:adventure_id])
    # @page = @adventure.pages.find(params[:name])
  end

  def new
    load_adventure
    @page = @adventure.pages.new
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

  def edit
  end

  def update
    load_adventure
    page = Page.find_by_id(params[:id])
    page.update(page_params)
    redirect_to edit_adventure_path(adventure)
  end

  def load_page
    @page = @adventure.pages.find(params[:id])
    redirect_to root_path if @page.blank?
  end

  private
  def page_params
    params.require(:page).permit(:name, :text)#, :adventure_attributes=>[:adventure_id])
  end

end
