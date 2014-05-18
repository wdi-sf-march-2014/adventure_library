class AddAdventureIdRefToPages < ActiveRecord::Migration
  def change
    add_reference :pages, :adventure_id, index: true
  end
end
