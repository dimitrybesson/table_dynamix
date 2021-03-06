class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i(show edit update destroy)
  before_action :ensure_logged_in, only: %i(new create)

  def index
    if params[:sort_by]
      @restaurants = Category.find_by(name: params[:sort_by]).restaurants ##no category_id column
    elsif params[:search_by]
      @restaurants = Restaurant.where("name like ?", "%#{params[:search_by]}%")
    elsif params[:nearby]
      @restaurants = Restaurant.near(params[:nearby], params[:distance], units: params[:units])
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @reservation = @restaurant.reservations.build
    @review = @restaurant.reviews.build
    if current_user.is_a?(Owner)
      @reservation.date = Date.today
      @reservation.time = Time.now.beginning_of_hour
    end
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.owner = current_user
    if @restaurant.save
      redirect_to owners_url, notice: "Restaurant Added!"
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @restaurant.update_attributes(restaurant_params)
      # flash
      redirect_to owners_url, notice: "Updated!"
    else
      render :edit
    end
  end

  def destroy
    @restaurant.destroy
    # flash
    redirect_to owners_url, notice: "Deleted."
  end

  def search


  end

  def search_results
    @restaurants = Restaurant.all
    @restaurants = Category.find_by(name: params[:category]).restaurants unless params[:category].empty?
    @restaurants = @restaurants.where(price: price_range_collect) unless price_range_collect.empty?
    @restaurants = @restaurants.near(params[:nearby], params[:distance], units: params[:units]) unless params[:nearby].empty?
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :capacity, :owner_id, :description, :phone, :open_time, :close_time, :price, :menu, :address, :picture, category_ids: [])
  end

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def price_range_collect
    list = []
    if params[:price_range1]
      list << params[:price_range1].to_i
    end
    if params[:price_range2]
      list << params[:price_range2].to_i
    end
    if params[:price_range3]
      list << params[:price_range3].to_i
    end
    list
  end

end
