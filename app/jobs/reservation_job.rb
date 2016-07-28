# example to create a job

# class ReservationJob < ActiveJob::Base
#   queue_as :default 

#   def perform(listing_id)
#     # Do something later
#     listing = Listing.find(listing_id)
#     ReservationMailer.new_reservation(listing.user).deliver_now
#   end
# end
