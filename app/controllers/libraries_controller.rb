class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    respond_to do |format|
      format.json { render :json => { libraries: @libraries.as_json(only: [ :url ])}, status: :ok }
      format.html { render :index }
    end
  end

  def show
    #@library = Library.find(params[:id])
    #@adventures = @library.adventures.all
  end
end
