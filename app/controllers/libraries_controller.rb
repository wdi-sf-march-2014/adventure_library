class LibrariesController < ApplicationController

	def index
		@libraries = Library.all
	end

# Don't need this bc we instantiate the new library in the Adventures controller (?)
	# def new
	# 	@library = Library.new
	# end

	def create
		@library = Library.create(library_params)
		if @library.save
			LibrariesWorker.perform_async(@library.id)
			redirect_to root_path
		else
			flash[:errors] = @library.errors.full_messages
			render :new
		end
	end

	private
		def library_params
			params.require(:library).permit(:url)
		end
end
