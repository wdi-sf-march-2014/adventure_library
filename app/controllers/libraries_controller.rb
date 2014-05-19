class LibrariesController < ApplicationController

   def index
    #Add logic for responding with a set of urls for other libraries in .json format
    @libraries = Library.all
    respond_to do |format|
        @libraries.each do |library|
        format.json { render json: {"libraries" => library.as_json(except: :id)} }
      end
    end
  end

   def create
    @library = Library.create library_params
    if @library.save
      AdventuresWorker.perform_async(@library.id)
    end
    redirect_to(root_path)
  end

    private
    def library_params
      params.require(:library).permit(:url)
    end
end


