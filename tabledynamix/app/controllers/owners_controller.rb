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
    # Here, you should set owner into an instance variable and use that in the view.
    # It's just more "proper" than straight up using current_user, because Rails coders expect to find
    # an instance variable named @owner in the app/views/owners/show.html.erb view.
    @owner = current_user
  end

  private

  def owner_params
    params.require(:owner).permit(:email, :password, :password_confirmation)
  end

end
