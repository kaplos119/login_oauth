class AddStateIdToCities < ActiveRecord::Migration
  def change
    add_column :cities, :state_id, :integer
    add_index :cities, :state_id
  end
end
