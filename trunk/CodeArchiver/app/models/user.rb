class User < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password
  validates_uniqueness_of :username, :case_sensitive => false  
  
  has_one :profile
  has_many :codes
end
