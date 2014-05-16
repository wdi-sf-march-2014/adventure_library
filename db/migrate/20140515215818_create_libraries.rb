class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :URL

      t.timestamps
    end
  end
end
