class AddIdToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :adventure_id, :integer
  end
end
