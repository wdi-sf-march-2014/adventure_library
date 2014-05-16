class AdventuresController < ApplicationController

  def index
    @adventures = Adventure.all
  end

  def new
    @adventure = Adventure.new
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update
  end

  def show
    # id = params[:id]
    @adventure = Adventure.find(params[:id])
    @start = Adventure.find(@adventure).pages.find_by(name: "start").id
    redirect_to adventure_page_path(@adventure, @start)
  end

  def create
    @adventure = Adventure.new adventure_params
    # BELOW LINE MIGHT BE WRONG
    adventure.create = SecureRandom.urlsafe_base64(10)
    if @adventure.save
    redirect_to root_path
    else
      flash[:errors] = @adventure.errors.full_messages
      render :edit
    end
  end

private
  def adventure_params
    params.require(:adventure).permit(:title, :author, :url)
  end

end
