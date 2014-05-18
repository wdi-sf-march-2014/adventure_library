class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :author
      t.string :GUID

      t.timestamps
    end
  end
end
