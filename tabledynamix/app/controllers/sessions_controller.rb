class SessionsController < ApplicationController
  def new
  end

  def create
    if params[:user_type] == "customer"
      customer = Customer.find_by(email: params[:email])
      if customer && customer.authenticate(params[:password])
        session[:customer_id] = customer.id
        session[:owner_id] = nil
        redirect_to restaurants_url
      else
        render :new
      end
    elsif params[:user_type] == "owner"
      owner = Owner.find_by(email: params[:email])
      if owner && owner.authenticate(params[:password])
        session[:owner_id] = owner.id
        session[:customer_id] = nil
        redirect_to restaurants_url
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
    redirect_to restaurants_url
  end
end
