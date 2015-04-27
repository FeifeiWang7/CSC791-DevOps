class RecommendationController < ApplicationController
  def view
    @categories=Array.new
    @recjobs=Array.new
    @user=current_user
    @jobapplications=@user.jobapplications
    @jobapplications.each do |jobapplication|
      @job=Job.find(jobapplication.job_id)
      @categories.append(@job.field)
    end
    @categories.each do |category|
      @reccjobs=Job.find_by_sql ["SELECT * FROM jobs WHERE field='#{category}'"]
      @reccjobs.each do |filterjob|
        if filterjob!=@job and filterjob.outdated==FALSE
          @recjobs.append(filterjob)
        end
      end
    end
    return @recjobs
  end
end
