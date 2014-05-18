class AdventuresController < ApplicationController
  include PagesHelper

  def index
    @adventures = Adventure.all
    @library = Library.new
    @local_adventures = @adventures.where(library_id: nil)
    respond_to do |format|
      format.html
      format.json { render :json => {:adventures => @adventures.as_json(except: [:id, :library_id], include: {:pages => {except: [:id, :adventure_id, :created_at, :updated_at]} })} }
    end
  end

  def new
    @adventure = Adventure.new
    @page = @adventure.pages.build
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end

  def update
  end

  def show
    @adventure = Adventure.find_by_id(params[:id])
    @page = @adventure.pages.find_by_name("start")
  end

  def create
    @adventure = Adventure.new adventure_params
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    if @adventure.save
    redirect_to new_adventure_page_path(@adventure)
    else
      flash[:errors] = @adventure.errors.full_messages
      render :edit
      redirect_to :back
    end
  end

  def edit
    @adventure = Adventure.find_by_id(params[:id])
  end

  def update
    @adventure = Adventure.find_by_id(params[:id])
    redirect_to(@adventure)
  end

  def destroy
      @adventure = Adventure.find(params[:id])
      @adventure.destroy
      redirect_to root_path
  end

private
  def adventure_params
    params.require(:adventure).permit(:title, :author, :pages_attributes=>[:name, :text], :libraries_attributes=>[:url])
  end

end
