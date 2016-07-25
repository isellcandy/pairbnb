class Tag < ActiveRecord::Base
	has_many :listingtags, dependent: :destroy
	has_many :listings, through: :listingtags
end
