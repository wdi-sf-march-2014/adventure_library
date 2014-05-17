class LibrariesController < ApplicationController

  def index
    #json respond_to here
  end

  def create
    @library = Library.create(params[:url])
  end

  

end
