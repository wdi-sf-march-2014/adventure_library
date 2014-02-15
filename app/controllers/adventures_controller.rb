class AdventuresController < ApplicationController
  def index
    @local_adventures = Adventure.where(:library_id => nil)
    @foreign_adventures = Adventure.where.not(:library_id => nil)
    respond_to do |f|
      f.html
      f.json do 
        render :json => {"adventures" => @local_adventures}
      end
    end
  end
end