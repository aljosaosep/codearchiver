class Code < ActiveRecord::Base
  validates_presence_of :code_body
  validates_presence_of :title
  validates_length_of :title, :maximum=>40
  validates_presence_of :description
  validates_presence_of :shortdescription
  validates_length_of :shortdescription, :maximum=>50, :message=>": Maximum 50 character allowed"
  validates_presence_of :user_id
  validates_presence_of :category_id
  validates_presence_of :type_id
  
  belongs_to :user
  belongs_to :program_language
  belongs_to :category
  belongs_to :type
  
  # Added by Edo, 23.3.2010
  has_many :grades
  has_one :code_replies
  has_many :comments
end
