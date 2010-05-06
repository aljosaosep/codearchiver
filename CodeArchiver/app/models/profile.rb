# Last edit by Aljosa Apr 26 10

class Profile < ActiveRecord::Base
  # attachment_fu stuff, for saving the image
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => 100.kilobytes,
                 :resize_to => '100x100>',
                 :thumbnails => { :thumb => '50x50>' },
                 :processor => 'ImageScience'

  #validates_as_attachment
  validates_presence_of :listing
  validates_presence_of :email


  # relationships
  belongs_to :user

  # Method returns picture path, if user has uploaded the image or
  # default_image path if he hasnt
  def picture_path
  	if self.filename == nil 
		  return "default.png" # user hasn't uploaded a picture. show default
	   else
		  return public_filename # return user's pic path
	   end
  end
  
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
