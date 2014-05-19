class LibrariesController < ApplicationController
  def index
    @libraries = Library.all

    respond_to do |f|
      f.html
      f.json { render json: {adventures: @myadventures.as_json(include: { pages: { only: [:name, :text] }} )}, status: 200} 
    end
  end

  def new
    @library = Library.new
  end

  def create
    new_adventure = params.require(:adventure).permit(:title, :author)
    new_adventure[:GUID] = SecureRandom.urlsafe_base64(10)
    @adventure = Adventure.create(new_adventure)
  end
end
