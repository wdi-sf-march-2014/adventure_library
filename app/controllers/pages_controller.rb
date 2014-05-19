class PagesController < ApplicationController
  before_action :load_adventure

  def index
    @pages = @adventure.page
  end
  
  def new
    @page = @adventure.pages.new
  end

  #{}"123".split(//).last(5).join

  def create
    @page = @adventure.pages.new(page_params)
    @page.adventure_id = @adventure.id
      if @page.save
        # if @page.name == 'start'
        #   [[ |:name]]
        #   redirect to adveture_page_path(@adventure)
        if @page.name == 'end'
          redirect_to root_path
        else
          redirect_to new_adventure_page_path(@adventure)
        end
      else
        flash[:errors] = @page.errors.full_messages
        render :new
    end
  end

  def show
     @page = @adventure.pages.find(params[:id])
  end

  def edit
    @page = @adventure.page.find(params[:id])
  end

  private
    def page_params
      params.require(:page).permit(:name, :text)
    end

    def load_adventure
      @adventure = Adventure.find(params[:adventure_id])
      redirect_to root_path if @adventure.blank?
    end

end
