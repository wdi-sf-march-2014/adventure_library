class PagesController < ApplicationController
	
	def index
    @pages = Page.all
  end

  def new
    @page = Page.new
  end

  def create
    @page = Page.create(page_params)
    redirect_to pages_path
  end

  private
  def page_params
    params[:post].permit(:name, :text)
  end

end

