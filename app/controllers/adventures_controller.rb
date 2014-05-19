class AdventuresController < ApplicationController
  #before_filter :load_action

  def index
    @library = Library.new
    @adventures = Adventure.all
    @local_adventures = Adventure.where(library_id = nil) 

    respond_to do |f|
      f.html
      f.json { render json: {adventures: @myadventures.as_json(include: { pages: { only: [:name, :text] }} )}, status: 200} 
    end
  end


  # def new
  #   @adventure = Adventure.new
  # end

  def show
    @adventure = Adventure.find(params[:id])
  end


  def destroy
    @adventure = Adventure.find(params[:id])
    @adventure.destroy
    redirect_to adventures_path
  end
end
