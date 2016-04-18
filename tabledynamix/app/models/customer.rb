class Customer < ActiveRecord::Base
  has_secure_password
  has_many :reservations
  has_many :restaurants, through: :reservations
  has_many :reviews
  has_many :restaurants, through: :reviews
  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
end
