class AddGuidToAdventure < ActiveRecord::Migration
  def change
    add_column :adventures, :GUID, :string
  end
end
