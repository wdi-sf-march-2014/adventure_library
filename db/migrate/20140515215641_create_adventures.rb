class CreateAdventures < ActiveRecord::Migration
  def change
    create_table :adventures do |t|
      t.string :title
      t.string :author
      t.timestamp :timestamps
      t.string :GUID

      t.timestamps
    end
  end
end
