class CodeReply < ActiveRecord::Base
  belongs_to :code
  validates_presence_of :child_id
  validates_presence_of :code_id
end
