class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:user_type] == "customer"
      customer = Customer.find_by(email: params[:email])
      if customer && customer.authenticate(params[:password])
        session[:customer_id] = customer.id
        session[:owner_id] = nil
        if session[:target]
          redirect_to new_restaurant_reservation_url(session[:target]), notice: "Welcome to Table Dynamix"
        else
          redirect_to restaurants_url, notice: "Welcome to Table Dynamix"
        end

      else
        render :new
      end
    elsif params[:user_type] == "owner"
      owner = Owner.find_by(email: params[:email])
      if owner && owner.authenticate(params[:password])
        session[:owner_id] = owner.id
        session[:customer_id] = nil
        redirect_to owners_url, notice: "Welcome to Table Dynamix"
      else
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    session[:customer_id] = nil
    session[:owner_id] = nil
    session[:target] = nil
    redirect_to restaurants_url, notice: "Hope to see you again soon!"
  end
end
