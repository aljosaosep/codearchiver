class Grade < ActiveRecord::Base
  belongs_to :user
  belongs_to :code
  validates_presence_of :user_id
  validates_presence_of :code_id
end
