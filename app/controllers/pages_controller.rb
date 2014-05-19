class PagesController < ApplicationController
before_action :load_action 

def index
  @pages = @adventure.pages.all
end

def show
  @page = @adventure.pages.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @page, status: :ok }
    end
end

def new
  @page = @adventure.pages.where(name: "start")
end

def create
  @page = @adventure.pages.create(pages_params)
end

def edit
  @page = @adventure.pages.where(name: "start")
end

def update
  @page = @adventure.pages.update_attributes pages_params
  redirect_to adventure_pages_path(@adventure)
end

def destroy
  @page = @adventure.pages.destroy
  redirect_to adventures_path
end

private
  def pages_params
    params.require(:page).permit(:name, :text)
  end

  def load_action
    @adventure = Adventure.find(params[:adventure_id])
  end

end
