class AdventuresController < ApplicationController

  respond_to :json

  def index 
    @library = Library.new
    @adventures = Adventure.all

    respond_with(@adventures) do |format|
      format.html {render "index"}
      format.json {render json: {adventures: @adventures}, except: :id, include: :pages}
    end 
  end

  def show
    @adventure = Adventure.find(params[:id])
  end

  def new
    @adventure = Adventure.new
    @adventure.pages.build
  end

  # def create
  #   @adventure = Adventure.new(adventure_params)
  #   @adventure.guid = SecureRandom.urlsafe_base64(10)
  #   if @adventure.pages.find_by(name: "start") != nil
  #     if @adventure.save
  #       redirect_to new_adventure_page_path(@adventure)
  #     end
  #   else
  #     flash[:errors] = @adventure.errors.full_messages
  #     render :edit
  #   end
  # end

  def create 
    @adventure = Adventure.new adventure_params
    if has_start_page? == true
      @adventure.save
    end
    redirect_to new_adventure_page_path(@adventure)
  end

  def edit 

  end

  def update

  end

  private
    def adventure_params
      params.require(:adventure).permit(:title, :author, :pages_attributes=>[:name, :text])
    end
end

 # def create
 #    # You must be signed in to create a listing, and this code fills in your user id:  
 #    @accommodation = current_user.accommodations.new(accommodation_params)
 #    if @accommodation.save
 #     redirect_to @accommodation, notice: 'Listing was successfully created.'
 #     else 
 #       redirect_to new_accommodation_path
 #    end
 #  end

 #  def show
 #    @accommodation = Accommodation.find(params[:id])
 #  end

 #  def edit
 #    @accommodation = Accommodation.find(params[:id])
 #  end

 #  def update

 #    @accommodation = Accommodation.find(params[:id])
 #      if @accommodation.user_id == current_user.id
 #        @accommodation.update_attributes accommodation_params
 #        redirect_to(accommodation_path)
 #      else
 #        flash[:errors]="You can't edit this because it's not yours."
 #        redirect_to(accommodation_path)
 #      end
 #  end

 #  def destroy
 #    @accommodation = Accommodation.find(params[:id])
 #      if @accommodation.user_id == current_user.id
 #        @accommodation.delete
 #        redirect_to(accommodation_path)
 #      else
 #        flash[:errors]="You can't delete this because it's not yours."
 #        redirect_to(accommodation_path)
 #      end
 #  end

 #  private
 #    def accommodation_params
 #      params.require(:accommodation).permit(:price, :description, :listing_type, :locale, :city, :address1, :address2, :state, :zip, :phone, :image)
 #    end