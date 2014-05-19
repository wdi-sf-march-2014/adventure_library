class AdventuresController < ApplicationController
	respond_to :json, :html

	def index
		@adventures = Adventure.where(library_id: nil)
		@other_adventures = Adventure.where.not(library_id: nil)
	end

	def show
		@adventure = params[:id]
		@start = Adventure.find(@adventure).pages.find_by(name: "start").id
		redirect_to adventure_page_path(@adventure, @start)
	end

	def new
		@adventure = Adventure.new
		@pages = 10.times { @adventure.pages.build }
	end

	def create
		@adventure = Adventure.new(params[:adventure].permit(:title, :author, :pages_attributes=>[:name, :text]))
		if @adventure.save
      redirect_to adventures_path, notice: 'adventure was successfully created.'
    else
      redirect_to new_adventure_path, notice: 'please try again.'
    end
	end
	
	def edit
		@adventure = Adventure.find(params[:id])	
		@pages = @adventure.pages
	end

	def update
		@adventure = Adventure.find(params[:id])
		@adventure.update_attributes(adventure_params)
		redirect_to adventures_path
	end

	def destroy
	end

  private
  	def adventure_params
  		params.require(:adventure).permit(:title, :author, :library_id)
  	end
end
