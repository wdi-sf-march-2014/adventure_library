class AdventuresController < ApplicationController
    def index
    @adventures = Adventure.all
  end

  def show
    @adventure = params[:id]
    @start = Adventure.find(@adventure).pages.find_by(name: "start").id
    redirect_to adventure_page_path(@adventure, @start)
  end

  def new
    @adventure = Adventure.new
    @page = @adventure.pages.build
    # @pages = 3.times (@adventure.pages.build)
  end

  def create
    @adventure = Adventure.create(params[:adventure].permit(:title, :author, :page_attributes => [:text]))
    @adventure.GUID = SecureRandom.urlsafe_base64(10)
    @adventure.save
    redirect_to new_adventure_page_path(@adventure)
    
    #render :new
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

  private
    def adventure_params
      params.require(:adventure).permit(:title, :author) 
    end

end
