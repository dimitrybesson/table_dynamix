class SessionsController < ApplicationController
  def new
  end

  def create
    customer = Customer.find_by(params[:email])
    if customer && customer.authenticate(params[:password])
      session[:customer_id] = customer.id
      redirect_to restaurants_url
    else
      
    end
  end

  def destroy
  end
end
