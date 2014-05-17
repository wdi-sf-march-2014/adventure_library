class PagesController < ApplicationController
    before_action :load_adventure

  def new
    @page = @adventure.pages.new
  end

  def create
    @page = @adventure.pages.new(page_params)
    page.adventure_id = @adventure.id
    if @page.save
      if @page.name = 'end'
        #redirect to index
      redirect_to root_path
      #[@adventure, @page]
      else 
        #redirect to new page path [(@adventure)]
        redirect_to new_adventure_page_path(@adventure)
      end
    else
      flash[:errors] = @page.errors.full_messages
      render :edit
    end
  end

  # def create
  #   @page = @adventure.pages.new(page_params)
  #   @page.adventure_id = @http://adventure.id
  #   if @page.save
  #     if@page.name == 'end'
  #       redirect_to root_path
  #     else
  #       redirect_to new_adventure_page_path(@adventure)
  #     end
  #   else
  #     flash[:errors] = @page.errors.full_messages
  #     render :new
  #   end
  # end

  def show
    #creating show for show pages via the adventure hash using the load method
    
    @page = @adventure.pages.find(params[:id])             
    # render adventure_page_path(@adventure, @page)
  end
               
  def edit

  end

  private
  def pages_params
    params.require(:page).permit(:name, :text)
  end

  def load_adventure
    @adventure = Adventure.find(params[:adventure_id])
      redirect_to root_path if @adventure.blank?
  end

end
