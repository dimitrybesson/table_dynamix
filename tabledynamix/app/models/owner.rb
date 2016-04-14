class Owner < ActiveRecord::Base
  has_many :restaurants
  has_many :reservations, through: :restaurants
  has_many :customers, through: :reservations
end
