class LibrariesController < ApplicationController
  # before_action :load_library

  def index
    @libraries = Library.all
  end

  def new
    @library = Library.new
  end

  def show
  end

  def scrape_library(library)
    response = Typhoeus.get("#{library.url}/libraries.json")
    result = JSON.parse(response.body)
    JSON.parse(response.body)
    return result
  end

  def create
    @library = Library.create library_params
    if @library.save
      scrape_library(@library)
      redirect_to root_path
    else
      flash[:errors] = @adventure.errors.full_messages
      render :edit
      redirect_to :back
    end
  end

  # def load_adventure
  #   @adventure = Adventure.find(params[:adventure_id])
  #   redirect_to root_path if @adventure.blank?
  # end


  # def load_library
  #   @library = @adventure.libraries.find(params[:id])
  #   redirect_to root_path if @library.blank?
  # end
private
  def library_params
    params.require(:library).permit(:url)
  end

end
