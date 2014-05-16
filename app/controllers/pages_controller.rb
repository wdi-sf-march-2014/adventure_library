class PagesController < ApplicationController
include PagesHelper
before_action :load_adventure

  def show
    @page = @adventure.pages.find(params[:id])
  end


  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
  end


end
