class AdventuresController < ApplicationController

  def index
    @adventures = Adventure.all
    respond_to do |format|
      format.html
      format.json { render :json => @adventures }
    end
  end

  def show
    @adventure = Adventure.find(params[:id])
    @start = @adventure.pages.find_by(name: "start").id
    redirect_to adventure_page_path(@adventure, @start)
  end

  def new
    @adventure = Adventure.new
    @page = @adventure.pages.build
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    if @adventure.save
      redirect_to new_adventure_page_path(@adventure)
    else
      render :edit
    end
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def destroy
    @adventure = Adventure.find(params[:id]).destroy
    # @adventure.delete
    redirect_to root_path
  end

  private
    def adventure_params
      params.require(:adventure).permit(:title, :author, :pages_attributes => [:name, :text])
    end

end

