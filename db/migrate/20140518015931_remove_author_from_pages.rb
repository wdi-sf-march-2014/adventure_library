class RemoveAuthorFromPages < ActiveRecord::Migration
  def change
    remove_column :pages, :author, :string
  end
end
