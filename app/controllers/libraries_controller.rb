class LibrariesController < ApplicationController

	# def index
	# 	@libraries = Library.all
	# end

	# def new
	# 	@library = Library.new
	# end

	def create
	  @library = Library.create(library_params)
	  scrape(@library)
	  redirect_to adventures_path
	end

	def scrape(library)
		response = Typhoeus.get("#{library.URL}/libraries.json")
		result = JSON.parse(response.body)
		result['libraries'].each do |l|   ##rails c (SE)
			@library = Library.new
			@library.url = l['url']
			@library.save
		end
	end

	private
	  def library_params
	    params.require(:library).permit(:URL) #:adventure_id, :adventures_attributes=>[:title]
	  end

end
  