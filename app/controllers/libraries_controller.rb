class LibrariesController < ApplicationController

  def index
    @libraries = Library.all
    @libraries.each do |library|
      AdventuresWorker.perform_async(library.url)
    end
  end

  def new
    @library = Library.new
  end

  def create
    library = Library.new(library_params)
    LibrariesWorker.perform_async(library.url)
    if library.save
      redirect_to libraries_path
    else
      flash[:errors] = @adventure.errors.full_messages
      render :new
    end
  end

private
  def library_params
    params.require(:library).permit(:url)
  end

end

