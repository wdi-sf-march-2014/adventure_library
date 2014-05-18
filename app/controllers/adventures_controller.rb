class AdventuresController < ApplicationController
    def index
    @library = Library.new
    @adventures = Adventure.all
  end

  def create_library 
    @library = Library.new(params[:url])
  end

  def show
    # binding.pry
    @adventure = Adventure.find(params[:id])
    @start = @adventure.pages.find_by(name: "start")
    #binding.pry
    redirect_to adventure_page_path(@adventure, @start)
  end

  def new
    @adventure = Adventure.new
    @page = @adventure.pages.build
    # @pages = 3.times (@adventure.pages.build)
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.GUID = SecureRandom.urlsafe_base64(10)
    if @adventure.save
    redirect_to new_adventure_page_path(@adventure)
    else 
      render:edit
    end
    #render :new
    #, :page_attributes => [:text]
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
    @adventure = Adventure.find(params[:id]).destroy
    
    redirect_to root_path
  end

    # def json_rescue
    #   JSON.parse("bad json")
    # rescue JSON.parse errors
    #   l.destroy
    # end
  private
    def adventure_params
      # binding.pry
      params.require(:adventure).permit(:title, :author) 
    end


end
