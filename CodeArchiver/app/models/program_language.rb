# Last edit by Aljosa Apr 26 10

class ProgramLanguage < ActiveRecord::Base
	# relationships
	belongs_to :code

	# presence validation
	validates_presence_of :language_name

	# uniquness validation
	validates_uniqueness_of :id

	# other stuff
  	validates_length_of :language_name, :maximum=>50, :message=>": Wtf? Language name more than 50 characters long?"
end
