class Reservation < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :customer
  validate :can_accomodate_party
  validate :during_operating_hours

  def can_accomodate_party
  #binding.pry

    reservations_on_day = Reservation.all.where(date: date)
    reservations_at_time = reservations_on_day.where(time: time)
    taken_spots = reservations_at_time.inject(0) {|sum, reservation| sum + reservation.party_size.to_i}

    if (restaurant.capacity.to_i - taken_spots.to_i) < party_size.to_i
      errors.add(:over_capacity, "Sorry, not enough seats")
    end
  end

  def during_operating_hours
    if (time < restaurant.open_time) || (time >= restaurant.close_time)
      errors.add(:not_open, "Sorry, we are not open at that time")
    end
  end
end
