class PagesController < ApplicationController

  def new
    @page = Page.new
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to adventure_page_path
    else
      flash[:errors] = @page.errors.full_messages
      render :edit
    end
  end

  def show
     @page = Page.find(params[:id])
  end

  private
    def page
      params.require(:page).permit(:name, :text)
    end

end
