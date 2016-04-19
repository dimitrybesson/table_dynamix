class UserMailer < ApplicationMailer
  def reservation_confirmation(user, reservation)
    @user = user
    @reservation = reservation
    mail(to: @user.email, subject: 'Reservation confirmation from Table Dynamix')
  end

  def reminder(user, reservation)
    @user = user
    @reservation = reservation
    mail(to @user.email, subject: "Your reservation at #{@reservation.restaurant}!")
  end
end
