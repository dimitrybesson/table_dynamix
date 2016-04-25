class SessionsController < ApplicationController
  def new
  end

  # In this method I removed repititition (keeping things "DRY")
  # by executing "render :new" in one branch only.
  def create
    if params[:user_type] == "customer" &&
      (customer = Customer.find_by(email: params[:email])) &&
      customer.authenticate(params[:password])

      session[:customer_id] = customer.id
      session[:owner_id] = nil

      flash[:notice] = "Welcome to Table Dynamix"
      if session[:target]
        redirect_to new_restaurant_reservation_url(session[:target])
      else
        redirect_to restaurants_url
      end

    elsif params[:user_type] == "owner" &&
      (owner = Owner.find_by(email: params[:email])) &&
      owner.authenticate(params[:password])

      session[:owner_id] = owner.id
      session[:customer_id] = nil

      redirect_to owners_url, notice: "Welcome to Table Dynamix"
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
