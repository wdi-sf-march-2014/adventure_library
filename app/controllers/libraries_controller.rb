class LibrariesController < ApplicationController

	def index
		@libraries = Library.all
		respond_to do |format| 
      format.html
      format.json { render json: { libraries: @libraries } }  
    end
	end

	def new
		@library = Library.new
		respond_to do |format| 
      format.html
      format.json { render json: { } }  
    end
	end

	def scrape(library)
		# response = Typhoeus.get("#{library.URL}/libraries.json")
		response = Typhoeus.get('adventures-with-raphael.herokuapp.com/libraries.json')
		result = JSON.parse(response.body)
		result['libraries'].each do |l|   ##rails c (SE)
			@library = Library.new
			@library.url = l['url']
			@library.save
		end
	end

	def create
	  @library = Library.create(library_params)
	  scrape(@library)
	  redirect_to adventures_path
	end


	private
	  def library_params
	    params.require(:library).permit(:URL) #:adventure_id, :adventures_attributes=>[:title]
	  end

end
  