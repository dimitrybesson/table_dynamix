class ReservationsController < ApplicationController
  before_action :find_restaurant, only: %i(index new create edit update destroy)
  before_action :ensure_logged_in

  def new
    @reservation = @restaurant.reservations.build
  end

  def create # add party_size validation vs capacity
    @reservation = @restaurant.reservations.build(reservation_params)

    @reservation.customer = current_user if current_user.is_a?(Customer)

    # What happens if current_user is an Owner? I don't quite understand what would happen here

    if @reservation.save
      UserMailer.reservation_confirmation(current_user, @reservation).deliver_now
      redirect_to root_url, notice: "Reservation Confirmed!"
    else
      render :new
    end
  end

  def index
    @reservations = @restaurant.reservations
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

    # It's good practice to check the status of destroy.
    # Perhaps you might have a validation that disallows a reservation within an hour of the reserved time, for example...
    # http://stackoverflow.com/a/12646791
    if @reservation.destroy && @reservation.destroyed?
      flash[:notice] = 'Reservation cancelled'
    else
      flash[:error] = 'Could not cancel reservation'
    end

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
