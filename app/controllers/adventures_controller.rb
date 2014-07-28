class AdventuresController < ApplicationController
  before_action :load_adventure_by_id, only: [:show, :edit, :update, :destroy]
  
  def index
    @adventures = Adventure.all.where.not(library_id: nil)
    @my_adventures = Adventure.all.where(library_id: nil)
    respond_to do |format|
      format.json { render :json => { adventures: @my_adventures.as_json(only: [:guid, :title, :author, :created_at, :updated_at], include: { :pages => {only: [:name, :text]} })}, status: :ok }
      format.html { render :index }
    end
  end
  
  def scrape
    url = params["link"]["url"]
    if url.include?("http://") && url.include?("heroku")
      LibrariesWorker.perform_async(url)
      flash[:sucess] = "Libraries are being scraped from the URL you entered"
      redirect_to root_path
    else
      flash[:error] = "Please enter a real url from Heroku"
      redirect_to root_path
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
      adventure.pages.create(name: params["adventure"]["pages_attributes"]["0"]["name"], text: params["adventure"]["pages_attributes"]["0"]["text"])
      flash[:success] = "Adventure Created. Add more pages."
      redirect_to new_adventure_page_path(adventure)
    else
      flash[:error] = "You didn't do that correctly. Try again."
      redirect_to root_path
    end
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

  def load_adventure_by_id
    @adventure = Adventure.find(params[:id])
  end
end
