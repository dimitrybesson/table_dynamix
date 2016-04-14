class Customer < ActiveRecord::Base
  has_many :reservations
  has_many :restaurants, through: :reservations
end
