class AdventuresController < ApplicationController

	def index
    @adventures = Adventure.all
    # @page = @adventure.pages
  end

	def new
	  @adventure = Adventure.new
	end

	def create
	  @adventure = Adventure.create(adventure_params)
	  redirect_to adventures_path
	end

	def edit
	  @adventure = Adventure.find(params[:id])
	end

	def update
	  adventure = Adventure.find(params[:id])
	  adventure.update_attributes adventure_params
	  redirect_to adventure_path
	end

	def destroy
	  adventure = Adventure.find(params[:id])
	  adventure.delete
	  redirect_to adventure_path
	end

	private
	  def adventure_params
	    params.require(:adventure).permit(:title, :author, :timestamps, :GUID) #pages_attributes=>[:title])
	  end

end
