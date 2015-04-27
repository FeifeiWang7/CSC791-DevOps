class Jobapplication < ActiveRecord::Base
  validates_presence_of :name, :major
  validates_numericality_of :phone
  belongs_to :job
  belongs_to :user
end
