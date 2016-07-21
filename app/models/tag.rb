class Tag < ActiveRecord::Base
	has_many :listingtags
	has_many :listings, through: :listingtags
end
