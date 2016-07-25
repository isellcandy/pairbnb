class ReservationsController < ApplicationController


	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservation_params)
		@reservation.user_id = current_user.id
		if @reservation.save
			flash[:success] = "successfully reserved your position"
		else
			flash[:danger] = @reservation.errors.full_messages
		end
		redirect_to listing_path(@listing)
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to user_path(current_user.id) 
	end

	private
		def reservation_params
			params.require(:reservation).permit(:start_date, :end_date)
		end
end
