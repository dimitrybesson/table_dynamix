class ReservationsController < ApplicationController
  before_action :find_restaurant, only: %i(index new create edit update destroy)
  before_action :ensure_logged_in

  def new

  end

  def create # add party_size validation vs capacity
    @reservation = @restaurant.reservations.build(reservation_params)
    if current_user.is_a?(Customer)
      @reservation.customer = current_user
    end
    if @reservation.save
      UserMailer.reservation_confirmation(current_user, @reservation).deliver_later
      redirect_to root_url, notice: "Reservation Confirmed!"
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
      redirect_to customer_url(@reservation.customer), notice: "Reservation Updated!"
    else
      render :edit
    end
  end

  def destroy
    @reservation = @restaurant.reservations.find(params[:id])
    @reservation.destroy
    redirect_to customer_url(@reservation.customer), notice: "Reservation cancelled"
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
