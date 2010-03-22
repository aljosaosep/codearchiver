class Code < ActiveRecord::Base
  belongs_to :user
  belongs_to :program_language
  belongs_to :category
  belongs_to :type
end
