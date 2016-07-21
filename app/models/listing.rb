class Listing < ActiveRecord::Base
	belongs_to :user
	has_many :listingtags
	has_many :tags, through: :listingtags
end
