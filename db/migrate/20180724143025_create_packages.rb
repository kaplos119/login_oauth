class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :package_name
      t.integer :city_id

      t.timestamps
    end
    add_index :packages, :city_id
  end
end
