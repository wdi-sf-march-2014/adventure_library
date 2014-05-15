class RemoveLibraryFromToAdventure < ActiveRecord::Migration
  def change
    remove_column :adventures, :library_id, :string
  end
end
