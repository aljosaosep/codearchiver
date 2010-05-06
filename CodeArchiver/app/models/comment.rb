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

 	# Returns author's picture
  	# Output: pic path
	def getPicturePath
		#return User.find(self.user_id)
    @profile = Profile.find(:first, :conditions => {:user_id => self.user_id})
    if @profile.avatar != '' and @profile.avatar!=nil
      return @profile.avatar
    else
      return @profile.picture_path
    end
		#return Profile.find(:first, :conditions => {:user_id => self.user_id}).picture_path
	end
end
