class LibrariesController < ApplicationController

   def index
    #Add logic for responding with a set of urls for other libraries in .json format
    @libraries = Library.all
    respond_to do |format|
        @libraries.each do |library|
        format.json { render json: {"libraries" => library.as_json(except: :id)} }
      end
    end
  end

  def scrape_library(library)
   response = Typhoeus.get("#{library.url}/libraries.json")
   result = JSON.parse(response.body)
   result["libraries"].each do |url_link|
    if Library.find_by_url(url_link["url"])
      else
      @library = Library.new
      @library.url = url_link["url"]
      @library.save 
      response = Typhoeus.get("#{@library.url}/adventures.json")
      result = JSON.parse(response.body)
      result["adventures"].each do |adventure|
        if Adventure.find_by_guid(adventure["guid"])
          else
           local_adventure = Adventure.create(title: adventure["title"], author: adventure["author"], guid: adventure["guid"], library_id: @library.id)
           adventure["pages"].each do |page|
           Page.create(name: page["name"], text: page["text"])
           end
        end
      end
    end
  end
end

   def create
    @library = Library.create library_params
    if @library.save
      scrape_library(@library)
    end
    redirect_to(root_path)
  end

    private
    def library_params
      params.require(:library).permit(:url)
    end
end


