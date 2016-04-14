class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :date
      t.time :time
      t.integer :customer_id
      t.integer :restaurant_id
      t.integer :party_size

      t.timestamps null: false
    end
  end
end
