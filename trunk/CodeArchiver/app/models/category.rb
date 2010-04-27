class Category < ActiveRecord::Base
  validates_presence_of :name
  validates_uniqueness_of :name
	################################################
	# return all root categories 
	# (at the moment, all categories are root cat.)
	# order them by name
	################################################
	def self.find_root_categories
		find(:all, :order => "name")
	end
end
