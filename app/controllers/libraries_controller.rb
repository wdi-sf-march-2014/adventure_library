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

	def create
	  @library = Library.create(library_params)
	  if @library.save 
	  	LibraryWorker.perform_async(@library.id)  #LibraryWorker.perform_in(1.hour, @library.id)
	  	AdventureWorker.perform_async(@library.id)
	  	#scrape(@library)
	  	redirect_to adventures_path
	  else
	  	redirect_to adventures_path
	  end
	end

	private
	  def library_params
	    params.require(:library).permit(:url) #:adventure_id, :adventures_attributes=>[:title]
	  end

end
  