class LibrariesController < ApplicationController

  def index
    @library_new = Library.new
    @adventure = Adventure.all
    @library = Library.all
    respond_to do |format|
      format.html
      format.json { render :json => {"libraries" => @library}}
    end
  end

  def new
    @library = Library.new
  end

  def create
    @library = Library.find_or_create_by(library_params)
    # binding.pry
    if @library.save 
      LibrariesWorker.perform_async(library_params[:url])
      #AdventuresWorker.perform_async(library_params[:url])
      redirect_to libraries_path
    else
      render :new
    end
  end

  def show
    @library = Library.find(params[:id])
  end

  private
    def library_params
      params.require(:library).permit(:url)
    end
end


