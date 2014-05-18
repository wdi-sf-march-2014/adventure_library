class AddUrlToLibrary < ActiveRecord::Migration
  def change
    add_column :libraries, :url, :string
  end
end
