class AdventuresController < ApplicationController

  def index
    @adventure = Adventure.all
    @local_adventure = Adventure.where(library_id: nil)
      respond_to do |format|
      format.html
      format.json { render :json => {"adventures" => @local_adventure.as_json(except: :id, include: :pages)}}
    end
  end

  def new
    @adventure = Adventure.new
    @adventure.pages.build
    @page = Page.new
  end

  def create
    @adventure = Adventure.new(adventure_params)
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    if @adventure.save
      @adventure.pages.create 
      redirect_to root_path
  else 
    render :edit
  end
end

  def show
    @adventure = Adventure.find(params[:id])
    @page = @adventure.pages.where(name: "start")
    respond_to do |format|
      format.html
      format.json { render json: @adventure, status: :ok }
    end
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update
    @adventure = Adventure.find(params[:id])
    @adventure.update(adventure_params)
    redirect_to adventures_path
  end

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

