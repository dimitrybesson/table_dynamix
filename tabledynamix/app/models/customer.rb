class Customer < ActiveRecord::Base
  has_secure_password
  has_many :reservations
  has_many :restaurants, through: :reservations
  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
end
