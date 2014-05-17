class AdventuresController < ApplicationController

  before_action :load_adventure, only: [:edit, :update, :show]

  def index
    @library = Library.new
    @adventures = Adventure.all
    @local_adventures = Adventure.where(library_id: nil)
    respond_to do |format|
      format.html
      format.json {render :json => {:adventures => @adventures.as_json(except: [:id, :library_id], include: {:pages => {except: [:id, :adventure_id, :created_at, :updated_at]} })} }
    end
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    if @adventure.save
      redirect_to new_adventure_page_path(@adventure)
    end
  end

  def show
    #still need to work on this method
    @adventure = Adventure.find(params[:id])
    #@pages = @adventure.pages
  end

  def edit
    #@adventure = Adventure.find(params[:id])
  end

  def update
    adventure = Adventure.find(params[:id])
    adventure.update_attributes adventure_params
    redirect_to(adventure)
  end

  def destroy
    adventure = Adventure.find(params[:id])
    adventure.delete
    redirect_to(adventures_path)
  end

  private
    def load_adventure
      @adventure = Adventure.find(params[:id])
    end
    def adventure_params
      params.require(:adventure).permit(:title, :author)
    end

end
