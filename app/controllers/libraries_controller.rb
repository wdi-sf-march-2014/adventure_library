class LibrariesController < ApplicationController

  def scrape_library(library)
   response = Typhoeus.get("#{library.url}/libraries.json")
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


