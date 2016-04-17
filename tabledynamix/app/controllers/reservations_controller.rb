class ReservationsController < ApplicationController
  before_action :find_restaurant, only: %i(index new create edit update destroy)
  before_action :ensure_logged_in

  def new
    @reservation = @restaurant.reservations.build
  end

  def create # add party_size validation vs capacity
    @reservation = @restaurant.reservations.build(reservation_params)
    @reservation.customer = current_user
    if @reservation.save
      UserMailer.reservation_confirmation(current_user).deliver_later
      redirect_to root_url
    else
      render :new
    end
  end

  def index
    @reservations = @restaurant.reservations.all
  end

  def edit
    @reservation = @restaurant.reservations.find(params[:id])
  end

  def update
    @reservation = @restaurant.reservations.find(params[:id])
    if @reservation.update_attributes(reservation_params)
      # Flash
      redirect_to customer_url(@reservation.customer)
    else
      render :edit
    end
  end

  def destroy
    @reservation = @restaurant.reservations.find(params[:id])
    @reservation.destroy
    # Flash
    redirect_to customer_url(@reservation.customer)
  end

  private
  def reservation_params
    params.require(:reservation).permit(:date, :time, :party_size)
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def formatted_time

  end
end
