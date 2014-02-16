class LibrariesController < ApplicationController
  def index
    @libraries = Library.all
    render :json => {"libraries" => @libraries}
  end

  def create
    u = params.require(:library).permit(:url)[:url]
    l = Library.find_or_create_by(:url => Library.normalize_url(u))
    ScraperWorker.perform_async(l.id)
    flash[:notice] = "You have added a library at #{l.url}.  Please refresh in a couple seconds to see the scraped stories."
    redirect_to adventures_path
  end
end