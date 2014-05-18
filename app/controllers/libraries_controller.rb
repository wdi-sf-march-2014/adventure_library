class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    respond_to do |format|
      format.json { render :json => { libraries: @libraries.as_json(only: [ :url ])}, status: :ok }
      format.html { render :index }
    end
  end

  url = "http://adventures-with-raphael.herokuapp.com/"
  def scrape(url)
    #call LibrariesWorker
    #LibrariesWorker.perform_async(url)
    if url.end_with?("json")
      response = Typhoeus.get(url)
    else
      response = Typhoeus.get(url + "/libraries.json")
    end
    parse = JSON.parse(response.body)
    parse["libraries"].each do |library|
      if Typhoeus.get(library["url"] + "libraries.json").response_code == 200 && Library.where(["url = ?", library["url"]]).empty? == true && library["url"].include?("heroku") == true
        lib = Library.create(library)
        # AdventuresWorker.perform_async(lib.id)
        adventure_response = Typhoeus.get(lib.url + "adventures.json")
        adventure_parse = JSON.parse(adventure_response.body)
        if adventure_parse.is_a?(Hash)
          adventures = adventure_parse["adventures"] #adventures is an array
          adventures.each do |adventure| #each adventure is a hash
            if adventure["pages"] != nil
              if Adventure.where(["guid = ?", adventure["guid"]]).empty? == true && adventure["pages"].find { |h| h["name"] == "start" } != nil && adventure["pages"].find { |h| h["name"] == "end" } != nil
                save_adventure = lib.adventures.create(guid: adventure["guid"], title: adventure["title"], author: adventure["author"]) #library_id: lib.id
                adventure["pages"].each do |page| #each page is a hash, #adventure["pages"] is an array
                  save_adventure.pages.create(name: page["name"], text: page["text"]) #adventure_id: save_adventure.id
                end
              end
            end
          end
        end      
      end
    end
  end
  # url = "http://adventures-with-raphael.herokuapp.com/libraries.json"
  # def scrape(url)
  #   JSON.parse(Typhoeus.get(url).body)["libraries"].each do |link|
  #     if Typhoeus.get(link["url"] + "libraries.json").response_code == 200
  #       Library.create(link)
  #       binding.pry
  #       scrape(link["url"])
  #     end
  #   end
  # end
  #   def scrape(url)
  #   response = Typhoeus.get(url)
  #   parse = JSON.parse(response.body)
  #   libraries = parse["libraries"]
  #   libraries.each do |library|
  #     if Library.where(["url = ?", 'libraries["url"]']) == false && Typhoeus.get(library["url"] + "libraries.json").response_code == 200
  #         Typhoeus.get(library["url"] + "libraries.json")
  #         Library.create(library)
  #         binding.pry
  #     end
  #   end
  # end
  private
  def library_params
    params.require(:libary).permit(:url)
  end

  def adventure_params
    params.require(:adventure).permit(:title, :author)
  end
end

#p ary.find { |h| h['product'] == 'bcx' }['href']
# if adventure["pages"].find { |h| h["name"] == "start" } != nil
