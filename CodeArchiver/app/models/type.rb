# Last edit by Aljosa Apr 26 10

class Type < ActiveRecord::Base
	# relationships
	belongs_to :code

	# presence validation
	validates_presence_of :name

	# uniquness validation
	validates_uniqueness_of :id
end
