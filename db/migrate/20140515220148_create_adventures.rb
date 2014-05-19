class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :title
      t.string :author
      t.string :guid
      t.references :library

      t.timestamps
    end
  end
end
