class AdventuresController < ApplicationController
  #include AdventuresHelper
  def index

    @adventures = Adventure.all
    respond_to do |format|
        format.html
        format.json {status: :ok, render :json => {:adventures => @adventures.as_json(except: [:id, :library_id], include: {:pages => {except: [:id, :adventure_id, :created_at, :updated_at]} })} }
      end
  end

  def new
    @adventure = Adventure.new
  end

  def create
    adventure = Adventure.new adventure_params
    adventure.GUID = SecureRandom.urlsafe_base64
    adventure.save
    redirect_to(adventure)
  end

  def show
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
    def adventure_params
      params.require(:adventure).permit(:title, :author)
    end
end
