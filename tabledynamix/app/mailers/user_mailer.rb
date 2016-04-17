class UserMailer < ApplicationMailer
  def reservation_confirmation(user)
    @user = user
    mail(to: @user.email, subject: 'Reservation confirmation from Table Dynamix')
  end
end
