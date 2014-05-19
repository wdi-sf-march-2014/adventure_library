class PagesController < ApplicationController

include PagesHelper
  before_action :load_adventure

  def index
    @pages = @adventure.pages.all
  end

  def new
    load_adventure
    @page = @adventure.pages.build
  end

  def create
    load_adventure
    @page = @adventure.pages.create page_params
    redirect_to root_path
  end

  def show
    @page = @adventure.pages.find(params[:id])
    redirect_to root_path if @page.blank?
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
    redirect_to root_path if @adventure.blank?
  end

   private
  def page_params
    params.require(:page).permit(:name, :text, :adventure_attributes=>[:adventure_id])
  end

end
