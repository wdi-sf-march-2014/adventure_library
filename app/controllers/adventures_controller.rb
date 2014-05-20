class AdventuresController < ApplicationController

	def index
		@adventures = Adventure.all
		respond_to do |format|
			format.html
			format.json { render :json => {:adventures => @adventures.as_json(except: [:id, :library_id], include: {:pages => {except: [:id, :adventure_id, :created_at, :updated_at]}} )}}
		end
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
		@page = @adventure.pages.build
		# @pages = 3.times { @adventure.paged.build }
	end

	def create
		@adventure = Adventure.new(adventure_params)
		@adventure.guid = SecureRandom.urlsafe_base64(10)
		if @adventure.save
			redirect_to new_adventure_page_path(@adventure)
		else
			render :new
		end
	end

	def show
		@adventure = Adventure.find(params[:id])
		@start = @adventure.pages.find_by(name: "start").id
		redirect_to adventure_page_path(@adventure, @start)
	end

	def edit
		@adventure = Adventure.find(params[:id])
	end

	def update
		@adventure = Adventure.find(params[:id])
		if @adventure.update(adventure_params)
			redirect_to adventure_path(@adventure)
		else
			flash[:errors] = @adventure.errors.full_messages
			render :edit
		end
	end

	def destroy
		@adventure = Adventure.find(params[:id])
		@adventure.destroy
		redirect_to root_path
	end

# Allows us to create a new instance of library from a form on the Adventures#index
	  def new_library
    @library = Library.new(params[:url])
  end

	private
		def adventure_params
			params.require(:adventure).permit(:title, :author, :pages_attributes => [:name, :text])
		end
end
