class ReservationMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reservation_mailer.new_reservation.subject
  #
  def new_reservation(user)
   	@user = user

    mail to: user.email, subject: "New Reservation"  
  end
end
