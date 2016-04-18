class ReviewsController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @review = @restaurant.reviews.build(review_params)
    @review.customer = current_user
    if @review.save
      redirect_to restaurant_url(@restaurant)
    else
      render 'restaurants/show'
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  private
  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
