class Job < ActiveRecord::Base
  validates_presence_of :name,:content,:field,:employer_name,:deadline,:tag
  has_many :jobapplications,dependent: :destroy
  belongs_to :employer
  has_one :category

  scope :by_search ,lambda{|search_text| where(Job.arel_table[:name].matches("%#{search_text}%").or Job.arel_table[:content].matches("%#{search_text}%").or Job.arel_table[:employer_name].matches("%#{search_text}%").or Job.arel_table[:field].matches("%#{search_text}%").or Job.arel_table[:tag].matches("%#{search_text}%") ) }

  def search_jobs(params)
    jobs=Job.by_search(params[:searchText])
    jobs = jobs.uniq
    return jobs
  end

  def applied_by(user)
    flag=TRUE
    self.jobapplications.each do |jobapplication|
        if jobapplication.user_id ==user.id
          flag=FALSE
          return flag
        end
    end
    flag
  end
  def outdated
    flag=FALSE
    if Time.now>self.deadline
      flag=TRUE
    end
    flag
  end
end
