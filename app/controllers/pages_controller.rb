class PagesController < ApplicationController
  def show
    @page = Page.find_by(:adventure_id => params[:adventure_id],
     :id => params[:id])
  end
end