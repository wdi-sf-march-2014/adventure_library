class LibrariesController < ApplicationController

def scrape_library(library)
  response = Typhoeus.get("#{library.url}/libraries.json")
  @result = JSON.parse(response.body)
  return @result
end

# def scrape_adventure(adventure)
#   response = Typhoeus.get("#{library.url}")
# end

def index
  @libraries = Library.all
end

def new
  @library = Library.new
end

def create
  @library = Library.create(library_params)
  scrape_library(@library)
  redirect_to libraries_path
end

def show
  @library = Library.find(params[:id])
end

private
def library_params
  params.require(:library).permit(:url)
end

end

