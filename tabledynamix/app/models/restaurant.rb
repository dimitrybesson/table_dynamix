class Restaurant < ActiveRecord::Base
  belongs_to :owner
  has_many :reservations
  has_many :customers, through: :reservations

  validates :name, :capacity, :phone, :open_time, :close_time, presence: true
  validates :capacity, numericality: {only_integer: true, greater_than: 0}
  validates :price, numericality: {only_integer: true, greater_than: 0, less_than: 4}
  ##phone number

  ##description
  ##menu
end
