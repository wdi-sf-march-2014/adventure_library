class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
  end

  def show
    @library = Library.find(params[:id])
    @adventures = @library.adventures.all
  end
end
