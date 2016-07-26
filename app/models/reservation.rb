class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :listing

	validates :start_date, presence: true
	validates :end_date, presence: true 

	def overlap?(rev)
		(self.start_date < rev.end_date && self.end_date > rev.start_date)
	end

	def wrongDate?
		self.end_date < self.start_date
	end
end

# !(start a > end b || end a < start b) 

# |----a------|
# 							|------b------|

# 							|------a------|
# |----b------|

# |----a------|
#   |--b--|