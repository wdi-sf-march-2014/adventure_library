class AdventuresController < ApplicationController
  before_action :adventure_find_by_id, except: [:index, :new, :create]
  
  def index
    @adventures = Adventure.all.where(library_id: !nil)
    @my_adventures = Adventure.all.where(library_id: nil)
    respond_to do |format|
      format.json { render :json => { adventures: @my_adventures.as_json(only: [:guid, :title, :author, :created_at, :updated_at], include: { :pages => {only: [:name, :text]} })}, status: :ok }
      format.html { render :index }
    end
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
