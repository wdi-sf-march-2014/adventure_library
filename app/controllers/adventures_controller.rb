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

  
  def create
    url = "user input"
    LibrariesWorker.perform_async(url)
  end
#if guid doesn't exist in adventures.all
#if start page doesn't exist
#if end page doesn't exist

  def scrape_adventures(library)
    @libraries = Library.all
    @libraries.each do |lib|
      response = Typhoeus.get(lib.url + "adventures.json")
      parse = JSON.parse(response.body)
      parse["title"].each do |link|
      if Typhoeus.get(link["url"] + "libraries.json").response_code == 200
        Library.create(link)
        binding.pry
        scrape(link)
      end
    end
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
