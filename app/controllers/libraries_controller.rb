class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    render :json => {"libraries" => @libraries}
  end
end