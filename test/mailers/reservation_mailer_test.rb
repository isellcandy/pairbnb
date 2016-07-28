require 'test_helper'

class ReservationMailerTest < ActionMailer::TestCase
  test "new_reservation" do
    mail = ReservationMailer.new_reservation
    assert_equal "New reservation", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
