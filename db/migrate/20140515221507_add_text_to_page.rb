class AddTextToPage < ActiveRecord::Migration
  def change
    add_column :pages, :text, :text
  end
end
