class AddTables < ActiveRecord::Migration

  def change
    create_table :adventures do |t|
      t.integer :library_id
      t.string :title
      t.string :author
      t.timestamps
      t.string :guid
    end

    create_table :pages do |t|
      t.string :name
      t.text :text
      t.integer :adventure_id
      t.timestamps
    end

    create_table :libraries do |t|
      t.text :url
    end
  end
end
