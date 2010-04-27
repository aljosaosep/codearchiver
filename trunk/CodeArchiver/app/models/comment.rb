class Comment < ActiveRecord::Base
	belongs_to :user
  	belongs_to :code
    validates_presence_of :user_id
    validates_presence_of :code_id
    validates_presence_of :content
    validates_length_of :content, :within => 2..100

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
