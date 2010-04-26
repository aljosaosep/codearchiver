class Profile < ActiveRecord::Base
  has_attachment :content_type => :image,
                 :storage => :file_system,
                 :max_size => 100.kilobytes,
                 :resize_to => '100x100>',
                 :thumbnails => { :thumb => '50x50>' },
                 :processor => 'ImageScience'

	#validates_as_attachment

  belongs_to :user


end
