class CustomersController < ApplicationController
  def index
    @customer = current_user
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      session[:customer_id] = @customer.id
      redirect_to restaurants_url
    else
      render :new
    end
  end

def show
  @customer = Customer.find(params[:id])
end

  private

  def customer_params
    params.require(:customer).permit(:email, :password, :password_confirmation)
  end

end
