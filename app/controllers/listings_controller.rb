class ListingsController < ApplicationController
	before_action :set_listings, only: [:show, :edit, :update, :destroy]

	def index 
		@listing = Listing.all
	end

	def show
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			@tag = params[:listing][:tags][:tag].split(",")
			@tag.each{ |x| x.gsub!(" ", "")}
			@tag = @tag.uniq
				@tag.each do |t|
					@listing.tags << Tag.find_or_create_by(tag: "#{t}")
				end
			redirect_to listing_path(@listing)	
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @listing.update(listing_params)
			redirect_to listing_path(@listing)
		else
			render :edit
		end
	end

	def destroy
		@listing.destroy
		redirect_to listings_path
	end

	private

	def listing_params
		params.require(:listing).permit(:title, :description, :tag, :price, :propertytype, :roomtype, :numberofguess)
	end

	def set_listings
		@listing = Listing.find(params[:id])
	end
end
