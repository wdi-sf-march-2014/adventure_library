class AddAssociationIDs < ActiveRecord::Migration
  def change
  	add_column :pages, :adventure_id, :integer
  	add_column :libraries, :adventure_id, :integer
  end
end
