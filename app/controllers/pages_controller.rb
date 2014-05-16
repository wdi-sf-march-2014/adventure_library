class PagesController < ApplicationController
  before_action :load_adventure
  before_action :load_page_instance_params, :only => [:show, :edit, :update, :destroy]

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
    if @page.save

    else
      render action: 'new'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

private
  def page_params
    params.require(:page).permit(:name, :text)
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
  end

  def load_page_instance_params
    @page = @adventure.pages.find(params[:id])
  end
end
