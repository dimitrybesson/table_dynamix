class Owner < ActiveRecord::Base
  has_secure_password
  has_many :restaurants
  has_many :reservations, through: :restaurants
  has_many :customers, through: :reservations
end
