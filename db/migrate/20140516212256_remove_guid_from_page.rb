class RemoveGuidFromPage < ActiveRecord::Migration
  def change
    remove_column :pages, :GUID, :string
  end
end
