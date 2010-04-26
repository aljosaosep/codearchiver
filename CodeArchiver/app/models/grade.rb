# Last edit by Aljosa Apr 26 10

class Grade < ActiveRecord::Base
  # relationships
  belongs_to :user
  belongs_to :code

  # presence validation
  validates_presence_of :user_id
  validates_presence_of :code_id
  validates_presence_of :value	
  #validates_presence_of :id

  # uniquness validation
  validates_uniqueness_of :id
end
