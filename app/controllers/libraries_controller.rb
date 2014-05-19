class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
  end

  def new
    @library=Library.new
  end

  def create
    @library= Library.create(library_parmas)
    redirect_to root_path
  end

  private
    def library_params
      params.require(:library)permit(:url)
    end

end
