class AdventuresController < ApplicationController

  def index
    @adventures = Adventure.all
  end

  def show
    @adventure = Adventure.find(params[:id])
    @start = Adventure.find(@adventure).pages.find_by(name: "start").id
    redirect_to adventure_page_path(@adventure, @start)
  end

  def new
    @adventure = Adventure.new
  end

  def create
    @adventure = Adventure.create(adventure_params)
    @adventure.guid = SecureRandom.urlsafe_base64(10)
    if adventure.save
      redirect_to adventures_path
    else
      render :edit
    end
  end

  def edit
    @adventure = Adventure.find(params[:id])
  end






end
