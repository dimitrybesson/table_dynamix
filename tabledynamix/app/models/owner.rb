class Owner < ActiveRecord::Base
  has_secure_password
  has_many :restaurants
  has_many :reservations, through: :restaurants
  has_many :customers, through: :reservations
  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
end
