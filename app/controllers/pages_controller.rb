class PagesController < ApplicationController
  
  before_action :load_adventure #find the adventure that the page belongs to before each of these methods run



  def index
    @pages = @adventure.pages.all #Retrieve all of the pages for the adventure
  end

  def new
    @page = @adventure.pages.new #Make an empty new page for the adventure that will be passed along to the form
  end

  def show
    @page = @adventure.pages.find(params[:id])
  end

  def create
    @page = @adventure.pages.create(page_params) #Create a new page for this adventure and call the page_params method for the params
    @page[:user_id] = current_user.id
    if @page.save #If the page saves to the database
      redirect_to adventure_pages_path(@adventure) #Redirect to the adventure's page's index
    end
  end

  private #Only self can use these methods. Note that for protected, both self and is_a?(self) can use these methods
          #is_a?(self) returns true if it has a class self or if it is a subclass of self
    def load_adventure
      @adventure = Adventure.find(params[:adventure_id]) #Find the adventure that the page belongs to
    end

    def page_params
      params.require(:page).permit(:name, :text) #Require that the params hash contains a bid, permit the amount attribute
    end

end
