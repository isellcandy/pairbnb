module ReservationsHelper
	def cart_total_price(rev)
		total = 0
		rev.each { |r| total += r.total_price } 
		total
	end
end
