class AppllistController < ApplicationController
  def list
    # session[:job_id]=params[:job_id]
    @job=Job.find(params[:job_id])

    # @job=Job.find(params[:job_id])
    @jobapplications=@job.jobapplications
    # @jobapplications=Jobapplication.find_by_job_id(params[:job_id])
    # @jobapplications=Jobapplication.order(:name)
  end
  def update_status
    @jobapplication=Jobapplication.find(params[:jobapplication_id])
    status=params[:update_status].to_s
    JobNotifier.stupdated(@jobapplication).deliver
    respond_to do |format|
      if @jobapplication.update(:status=>status)
        format.html { redirect_to appllist_list_url(:job_id=>@jobapplication.job_id), notice: 'Jobapplication was successfully updated.' }
        format.json { render :show, status: :ok, location: @jobapplication }
      else
        format.html { render :edit }
        format.json { render json: @jobapplication.errors, status: :unprocessable_entity }
      end
    end
  end
end
