class AdventuresController < ApplicationController
  before_action :adventure_find_by_id, except: [:index, :new, :create]
  
  def index
    # @library = Library.find(1)
    @adventures = Adventure.all
  end

  def show
    @pages = @adventure.pages
  end

  def new
    @adventure = Adventure.new
  end

  def create
    adventure = Adventure.new adventure_params
    if adventure.save
    else
    end
    redirect_to adventure_path
  end

  def edit
  end

  def update
    if @adventure.update_attributes adventure_params
    else
    end
    redirect_to adventure_path
  end

  def destroy
    @adventure.destroy
    redirect_to root_path
  end

private
  def adventure_params
    params.require(:adventure).permit(:title, :author)
  end

  def adventure_find_by_id
    @adventure = Adventure.find(params[:id])
  end
end
