class PagesController < ApplicationController

include PagesHelper

  def show
    @page = Page.find(params[:id])
  end

end
