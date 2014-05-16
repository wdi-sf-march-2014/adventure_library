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

  

  def create
    adventure = Adventure.new adventure_params
    # BELOW LINE MIGHT BE WRONG
    adventure.url = SecureRandom.urlsafe_base64(10)
    adventure.save
    redirect_to root_path
  end

private
  def adventure_params
    params.require(:adventure).permit(:title, :author, :url)
  end

end
