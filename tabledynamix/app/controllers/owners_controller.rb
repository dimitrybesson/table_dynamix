class OwnersController < ApplicationController
  def index

  end

  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      redirect_to restaurants_url
    else
      render :new
    end
  end


  private

  def owner_params
    params.require(:owner).permit(:email, :password, :password_confirmation)
  end

end
