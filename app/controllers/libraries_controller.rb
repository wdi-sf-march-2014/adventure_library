class LibrariesController < ApplicationController
  # before_action :load_library

  def index
    @libraries = Library.all
    @libraries.each do |library|
      AdventureWorker.perform_async(library.id)
    end
  end

  def new
    @library = Library.new
  end

  def show
    # @libraries = Library.all
  end
  
  def create
    library = Library.new(library_params)
    if library.save
      LibraryWorker.perform_async(library.id)
      redirect_to libraries_path
    else
      flash[:errors] = @adventure.errors.full_messages
      redirect_to :back
    end
  end
  
private
  def library_params
    params.require(:library).permit(:url, :id)
  end

end
