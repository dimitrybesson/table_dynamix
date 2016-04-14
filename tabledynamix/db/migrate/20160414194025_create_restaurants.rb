class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :capacity
      t.integer :owner_id

      t.timestamps null: false
    end
  end
end
