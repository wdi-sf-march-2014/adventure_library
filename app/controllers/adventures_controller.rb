class AdventuresController < ApplicationController
  #before_filter :load_action

  def index
    @adventures = Adventure.all
    @local_adventures = Adventure.where(library_id = nil)
  end

  # def new
  #   @adventure = Adventure.new
  # end

  # def create
  #   @adventure = Adventure.create(adventure_params)
  #   @adventure.save
  #   @adventure.update_attributes(:guid => SecureRandom.urlsafe_base64(10))
  #   redirect_to adventures_path
  # end

  def show
    @adventure = Adventure.find(params[:id])
  end

  # def edit
    
  #   @adventure = Adventure.find(params[:id])
  # end

  # def update
  #   @adventure = Adventure.find(params[:id])
  #   @adventure.update(adventure_params)
  #   redirect_to adventures_path
  # end

  def destroy
    @adventure = Adventure.find(params[:id])
    @adventure.destroy
    redirect_to adventures_path
  end


private
  def adventure_params
    params.require(:adventure).permit(:title, :author, :pages_attributes => [:name, :text])
  end
end
