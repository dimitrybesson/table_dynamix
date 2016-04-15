class RestaurantsController < ApplicationController
  before_action :ensure_logged_in, only: %i(new create)
  def index
    @restaurants = Restaurant.all
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.owner = current_user
    if @restaurant.save
      redirect_to restaurants_url
    else
      render :new
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :capacity, :owner_id, :description, :phone, :open_time, :close_time, :price, :menu)
  end

end
