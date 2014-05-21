class AddAuthorToAdventure < ActiveRecord::Migration
  def change
    add_column :adventures, :author, :string
  end
end
