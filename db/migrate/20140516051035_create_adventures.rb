class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :guid
      t.string :title
      t.string :author
      t.references :library, index: true

      t.timestamps
    end
  end
end
