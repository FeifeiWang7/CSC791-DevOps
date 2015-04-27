class Category < ActiveRecord::Base
  has_many :jobs
  validates_presence_of :category_name
end
