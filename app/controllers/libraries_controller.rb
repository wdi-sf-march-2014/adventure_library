class LibrariesController < ApplicationController

	def new
		@library = Library.new
	end

	def create
		@library = Library.create(library_params)
		if @library.save
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
