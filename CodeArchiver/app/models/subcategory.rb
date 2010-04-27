class Subcategory < ActiveRecord::Base
  belongs_to :category
  validates_presence_of :child_id
  validates_presence_of :category_id
end
