class ReservationsController < ApplicationController


	def create
		@listing = Listing.find(params[:listing_id])
		@reservation = @listing.reservations.new(reservation_params)
		if @reservation.wrongDate?
			flash[:danger] = "Start date is greater than end date"
		else
			reserve_check = Reservation.where(listing_id: @listing.id)
			reserve_check_count = reserve_check.count
			unless reserve_check.empty?

				reserve_check.each_with_index do |r, ind|
					if @reservation.overlap?(r)
						flash[:danger] = "date overlaps with other user"
						break
					elsif ind+1 == reserve_check_count
						if @reservation.overlap?(r)
							flash[:danger] = "date overlaps with other user"
							redirect_to listing_path(@listing)
						else
							@reservation.user_id = current_user.id
							@reservation.save
							flash[:success] = "successfully reserved your position"
						end	
					else
						next
					end
				end
			else
				@reservation.user_id = current_user.id
				@reservation.save
				flash[:success] = "successfully reserved your position"
			end
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
