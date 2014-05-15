class AdventuresController < ApplicationController

  def index
    @adventures = Adventure.all
    #show all of the adventures
  end

end
