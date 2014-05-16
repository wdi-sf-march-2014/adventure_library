class LibrariesController < ApplicationController

  def scrape_library(library)
   binding.pry
   response = Typhoeus.get("#{library.url}/libraries.json")
   response = Typhoeus.get("http://sleepy-garden-8077.herokuapp.com//libraries.json")
   result = JSON.parse(response.body)
   return result
  end
 
   def create
    @library = Library.create library_params
    scrape_library(@library)
    redirect_to(root_path)
  end



    private
    def library_params
      params.require(:library).permit(:url)
    end
end


