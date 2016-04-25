class Customer < ActiveRecord::Base
  has_secure_password

  # Never use the same name in two different associations
  # The second :restaurants association probably overwrote the first one.
  # The proper way to write these would have been:

  has_many :reservations
  has_many :reserved_restaurants, through: :reservations, class: 'Restaurant'
  has_many :reviews
  has_many :reviewed_restaurants, through: :reviews, class: 'Restaurant'

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
end
