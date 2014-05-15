class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :title
      t.string :author
      t.string :GUID
      t.references :library, index: true

      t.timestamps
    end
  end
end
