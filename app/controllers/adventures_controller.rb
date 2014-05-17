class AdventuresController < ApplicationController

def index
  @adventures = Adventure.all
  @library = Library.new
  respond_to do |format|
    format.html
    format.json { render json: @adventures}
  end
end

def new
  @adventure = Adventure.new
  @page = @adventure.pages.build
end

def create
  @adventure = Adventure.new(adventure_params)
  @adventure.GUID = SecureRandom.urlsafe_base64(10)
  
  if @adventure.save
    redirect_to adventures_path
  else
    flash[:errors] = @adventure.errors.full_messages
    render :edit
  end
end

def show
  @adventure = Adventure.find(params[:id])
  @start = @adventure.pages.find_by(name: "start").id
  redirect_to adventure_page_path(@adventure, @start)
end

def start
  
end

def edit
  @adventure = Adventure.find(params[:id])
end

def update
  @adventure = Adventure.find(params[:id])
  if @adventure.update(adventure_params)
    redirect_to root_path
  else
    flash[:errors] = @adventure.errors.full_messages
    render :edit
  end
end

def destroy
  @adventure = Adventure.find(params[:id])
  @adventure.delete
  redirect_to root_path
end

private
  def adventure_params
    params.require(:adventure).permit(:title, :author, pages_attributes: [:name, :text])
  end

end
