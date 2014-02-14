class AdventuresController < ApplicationController
  def index
    @adventures = Adventure.where(:library_id => nil)
    render :json => {"adventures" => @adventures.as_json(:include => :pages, :except => :id)}
  end
end