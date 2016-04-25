class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i(show edit update destroy)
  before_action :ensure_logged_in, only: %i(new create)

  def index
    # Here's a DRYer way of assigning the results of if/else to a variable
    @restaurants = if params[:sort_by]
      Category.find_by(name: params[:sort_by]).restaurants ##no category_id column
    elsif params[:search_by]
      Restaurant.where("name like ?", "%#{params[:search_by]}%")
    elsif params[:nearby]
      Restaurant.near(params[:nearby], params[:distance], units: params[:units])
    else
      Restaurant.all
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
    # It's good practice to check the status of destroy.
    # Perhaps you might have a validation that disallows destroying a restaurant when it still has pending reservations, for example...
    # http://stackoverflow.com/a/12646791
    if @restaurant.destroy && @restaurant.destroyed?
      flash[:notice] = 'Deleted.'
    else
      flash[:error] = 'Could not delete restaurant.'
    end
    redirect_to owners_url
  end

  # As mentioned in routes.rb, the search and search_results methods should be rewritten into a SearchesController.
  # These methods are not RESTful.
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
    # compact removes any nils
    [
      params[:price_range1].try(:to_i),
      params[:price_range2].try(:to_i),
      params[:price_range3].try(:to_i)
    ].compact
  end

end
