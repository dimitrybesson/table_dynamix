class Restaurant < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :owner
  has_many :reservations
  has_many :customers, through: :reservations
  has_many :reviews
  has_many :customers, through: :reviews
  geocoded_by :address
  after_validation :geocode, if: :address_changed?


  validates :name, :address, :capacity, :phone, :open_time, :close_time, :description, presence: true
  validates :description, length: {minimum: 20, maximum: 144}
  validates :capacity, numericality: {only_integer: true, greater_than: 0}
  validates :price, numericality: {only_integer: true, greater_than: 0, less_than: 4}



end
