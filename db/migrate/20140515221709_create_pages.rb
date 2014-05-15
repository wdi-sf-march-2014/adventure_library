class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :name
      t.string :text
      t.references :adventure

# references is what brings in the foreign key
      t.timestamps
    end
  end
end
