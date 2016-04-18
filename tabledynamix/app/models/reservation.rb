class Reservation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :customer
  validate :can_accomodate_party
  validate :during_operating_hours
  validates :date, :time, :party_size, :restaurant_id, presence: true
  validates :party_size, numericality: { only_integer: true, greater_than: 0 }
  validates :party_size, numericality: { only_integer: true, less_than: 21 } unless :boss_override

  def can_accomodate_party
    taken_spots = Reservation.all.where(date: date, time: time).sum(:party_size)

    if (restaurant.capacity - taken_spots) < party_size
      errors.add(:over_capacity, "Sorry, not enough seats")
    end
  end

  def during_operating_hours
    if (time.hour < restaurant.open_time.hour) || (time.hour >= restaurant.close_time.hour)
      errors.add(:not_open, "Sorry, we are not open at that time")
    end
  end
end
