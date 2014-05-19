class LibrariesController < ApplicationController
	respond_to :json

	def index
		@libraries = Library.all
	end

	def import
		url = params["import_library"]["url"]
		url.gsub!(/\/*$/,'')
    LibrariesWorker.perform_async(url)
    flash[:sucess] = "importing the library you requested. check back soon."
    redirect_to root_path
  end

end
