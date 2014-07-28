class PagesController < ApplicationController
  before_action :load_adventure
  before_action :load_page_by_id, :only => [:show, :edit, :update, :destroy]

  def index
    @page = @adventure.pages.find_by(name: "start")
    redirect_to adventure_page_path(@adventure, @page)
  end

  def show
  end

  def new
    @page = @adventure.pages.new
  end

  def create
    @page = @adventure.pages.new page_params
    if params[:next]
      if @page.save
        redirect_to new_adventure_page_path(@adventure)
      else
        flash[:error] = "You can't leave any field blank"
      end    
    elsif params[:end]
      if @page.save
        redirect_to root_path
      else
        flash[:error] = "You can't leave any field blank"
      end
    elsif params[:last_page]
      if @page.save
        redirect_to new_adventure_page_path(@adventure)
      else
        flash[:error] = "You can't leave any field blank"
      end
    end
  end

  def edit
  end

  def update
    @page.update_attributes page_params
    redirect_to adventure_page_path(@adventure, @page)
  end

  def destroy
    @page.delete
    redirect_to adventure_path(@adventure)
  end

private
  def page_params
    params.require(:page).permit(:name, :text)
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
  end

  def load_page_by_id
    @page = @adventure.pages.find(params[:id])
  end
end
