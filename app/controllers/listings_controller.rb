class ListingsController < ApplicationController
	before_action :set_listings, only: [:show, :edit, :update, :destroy]

	def index 
		@listing = Listing.order(created_at: :desc)
		@listing = @listing.paginate(:page => params[:page], :per_page => 5)
	end

	def show
		@reservation = Reservation.new
	end

	def new
		@listing = Listing.new
	end

	def create
		@listing = current_user.listings.new(listing_params)
		if @listing.save
			@tag = params[:listing][:tags][:tag].split(",")
			@tag.each{ |x| x.gsub!(" ", "")}
			@tag.map {|x| x.capitalize}
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
		@taglist = []
		@listing.tags.each {|x| @taglist << x.tag}
		@taglist = @taglist.join(",").gsub(" ",",")
	end

	def update
		if @listing.update(listing_params)
			
			@tag = params[:listing][:tags][:tag].split(",")
			@tag.each{ |x| x.gsub!(" ", "")}
			@tag.map {|x| x.capitalize}
			@tag = @tag.uniq
			latest_tag = []
				@tag.each do |t|
					unless Tag.find_by_tag(t).nil?
							find_tag_id = Tag.find_by_tag(t).id
							unless Listingtag.where(listing_id: @listing.id, tag_id: find_tag_id).first.nil?
								latest_tag << find_tag_id
								next		
							else
								new_tag = Tag.find_or_create_by(tag: "#{t}")
								@listing.tags << new_tag
								latest_tag << new_tag.id
							end
					else
						new_tag = Tag.create(tag: "#{t}")
						@listing.tags << new_tag
						latest_tag << new_tag.id
					end
				end
			old_tag = []
			Listingtag.where(listing_id: @listing.id).all.each { |t| old_tag << t.tag_id }
			if latest_tag == old_tag
				redirect_to listing_path(@listing)
			else
				delete_tag = old_tag - latest_tag
				delete_tag.each do |d|
					Listingtag.where(listing_id: @listing.id, tag_id: d).first.destroy
				end
				redirect_to listing_path(@listing)
			end
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
		params.require(:listing).permit(:title, :description, :price, :propertytype, :roomtype, :numberofguess, {avatars:[]})
	end

	def set_listings
		@listing = Listing.find(params[:id])
	end
end
