class JobpoolController < ApplicationController
  def index
    @user=current_user
    @jobs=Job.order(:created_at)
  end
  def search
    @user=current_user
    @text=params[:searchText]
    @jobs = Job.search_jobs(params)
  end
end
