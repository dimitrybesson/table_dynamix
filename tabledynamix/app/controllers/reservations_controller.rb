class ReservationsController < ApplicationController
  before_action :set_restaurant, only: %i(new create)
  before_action :ensure_logged_in

  def new
    @reservation = @restaurant.reservations.build
  end

  def create # add party_size validation vs capacity
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.customer = current_user
    if @reservation.save
      redirect_to root_url
    else
      render :new
    end
  end

  def index
  end

  private
  def reservation_params
    params.require(:reservation).permit(:date, :time, :party_size)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def formatted_time
    
  end
end
