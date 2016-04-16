class AddColumnsToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :description, :text
    add_column :restaurants, :phone, :string
    add_column :restaurants, :open_time, :time
    add_column :restaurants, :close_time, :time
    add_column :restaurants, :price, :integer
    add_column :restaurants, :menu, :text
  end
end
