task :say_hello => :environment do
  # puts "Hello World!"
  # reservations = Reservation.where(date: Date.tomorrow)
  #
  # reservations.each do |reservation|
  #
  #   puts reservation.date
  #   puts reservation.time.to_formatted_s(:time)
  #   puts reservation.restaurant
  #   puts -------------------
  puts 'Hello World!'
  Reservation.where(date: Date.tomorrow).each do |reservation|
    UserMailer.reminder(reservation.customer, reservation).deliver_now
  end



end
