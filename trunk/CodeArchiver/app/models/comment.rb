class Comment < ActiveRecord::Base
	belongs_to :user
  	belongs_to :code

	##########################################
	# Obj's name getter methods
	# Aljosa 11.4.10
	##########################################

  	# Returns author's name as string
  	# Output: name
	def getAuthorName
		return User.find(self.user_id).username
	end
end
