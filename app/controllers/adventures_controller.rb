class AdventuresController < ApplicationController

	def index
		@adventures = Adventure.all
	end
## When the user hits submit on 'add a library' in the index, they should call the scraped libraries method.
## This should be in the libraries_controller

# 	def scraped_libraries
# 		@url = params[:url]
# 		response = Typhoeus.get("#{@url}/libraries")
# binding.pry
# 		@scraped = JSON.parse(response.body)
# 	end

	def new
		@adventure = Adventure.new
		# @pages = 3.times { @adventure.paged.build }
	end

	def create
		@adventure = Adventure.new(adventure_params)
		@adventure.guid = SecureRandom.urlsafe_base64(10)
		@adventure.save
		redirect_to new_adventure_page_path(@adventure)
	end

# SAMPLE CODE FROM TIM'S NESTED RESOURCES
# def create
#   @parent = Parent.create(params[:parent].permit(:name, :children_attributes=>[:name]))
#   if @parent.save
#     redirect_to @parent, notice: 'Parent was successfully created.'
#   else
#     render action: 'new'
#   end
# end

	def show
		@adventure = Adventure.find(params[:id])
		@start = @adventure.pages.find_by(name: "start").id
		redirect_to adventure_page_path(@adventure, @start)
	end

	private
		def adventure_params
			params.require(:adventure).permit(:title, :author, :pages_attributes => [:name, :text])
		end
end
