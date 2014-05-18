class LibrariesController < ApplicationController
	respond_to :json

	def index
		@libraries = Library.all
	end

	def create
	end

	def update
	end

end
