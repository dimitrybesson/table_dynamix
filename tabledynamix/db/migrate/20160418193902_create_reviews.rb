class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :rating
      t.integer :customer_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
