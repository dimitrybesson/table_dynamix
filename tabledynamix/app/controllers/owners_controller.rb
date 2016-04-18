class OwnersController < ApplicationController
  def new
    @owner = Owner.new
  end

  def create
    @owner = Owner.new(owner_params)
    if @owner.save
      session[:owner_id] = @owner.id
      redirect_to restaurants_url, notice: "Restaurant Owner Registration Completed"
    else
      render :new
    end
  end

  def show

  end


  private

  def owner_params
    params.require(:owner).permit(:email, :password, :password_confirmation)
  end

end
