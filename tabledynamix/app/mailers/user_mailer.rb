class UserMailer < ApplicationMailer
  def reservation_confirmation(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: 'Reservation confirmation from Table Dynamix')
  end
end
