class PagesController < ApplicationController
  before_action :load_adventure
  
  def new
    @page = @adventure.pages.new
  end

  # def create
  #   @page = @adventure.page.new(page_params)
  #     if @page.save
  #       @page.name = 'new'
  #       redirect_to [@adventure, @page]
  #     else
  #       flash[:errors] = @page.errors.full_messages
  #       render :new
  #   end
  # end

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
