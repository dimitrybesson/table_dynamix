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

  # edit, update, and destroy don't seem to have been used -- so the methods should not exist in the controller.

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end
end
