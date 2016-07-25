class Listing < ActiveRecord::Base
	mount_uploaders :avatars, AvatarUploader
	belongs_to :user
	has_many :listingtags, dependent: :destroy
	has_many :tags, through: :listingtags
	has_many :reservations, dependent: :destroy

end
