class AdventuresController < ApplicationController

	def index
		@library = Library.new   #need to instantiate to get form to work
		# @page = Page.new
    @adventures = Adventure.all
		
		respond_to do |format|
      format.html
      format.json { render :json => {:adventures => @adventures.as_json(include: 
      	{:pages => {only: [:name, :text]} })} }
      format.xml { render xml: @adventures.to_xml}
    end
  end

	def new
	  @adventure = Adventure.new
	end

	def create
	  @adventure = Adventure.new(adventure_params)
	  @adventure.GUID = SecureRandom.urlsafe_base64
	  @adventure.save!
	  redirect_to adventures_path
	end

	def show
		@adventure = Adventure.find(params[:id])
  	@page = @adventure.pages.find(params[:id])
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
	    params.require(:adventure).permit(:title, :author, :timestamps, :GUID, :pages_attributes=>[:name]) #pages_at
	  end

end
