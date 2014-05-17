class PagesController < ApplicationController

include PagesHelper
  before_action :load_adventure

  def index
    @pages = @adventure.pages
  end

  def show
    @page = @adventure.pages.find(params[:id])
    redirect_to root_path if @page.blank?
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
    redirect_to root_path if @adventure.blank?
  end

end
