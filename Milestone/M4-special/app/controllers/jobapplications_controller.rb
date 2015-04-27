class JobapplicationsController < ApplicationController
  before_action :set_jobapplication, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /jobapplications
  # GET /jobapplications.json
  def index
    @user=current_user
    @jobapplications = @user.jobapplications
  end

  # GET /jobapplications/1
  # GET /jobapplications/1.json
  def show
  end

  # GET /jobapplications/new
  def new
    @job=Job.find(params[:job_id])
    session[:job_id]=params[:job_id]
    @jobapplication = Jobapplication.new
  end

  # GET /jobapplications/1/edit
  def edit
  end

  # POST /jobapplications
  # POST /jobapplications.json
  def create
    @user=current_user
    @job=Job.find(session[:job_id])
    @jobapplication = @user.jobapplications.build(job:@job)
    @jobapplication.name=jobapplication_params[:name]
    @jobapplication.phone=jobapplication_params[:phone]
    @jobapplication.major=jobapplication_params[:major]
    @jobapplication.coverletter=jobapplication_params[:coverletter]
    @jobapplication.status="Pending"
    @jobapplication.job_name=@job.name
    @jobapplication.email=current_user.email
    @jobapplication.job_id=@job.id
    JobNotifier.received(@jobapplication).deliver
    respond_to do |format|
      if @jobapplication.save(jobapplication_params)
        format.html { redirect_to @jobapplication, notice: 'Jobapplication was successfully created.' }
        format.json { render :show, status: :created, location: @jobapplication }
      else
        format.html { render :new }
        format.json { render json: @jobapplication.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobapplications/1
  # PATCH/PUT /jobapplications/1.json
  def update
    @user=current_user
    @job=Job.find(session[:job_id])
    @jobapplication.job_name=@job.name
    @jobapplication.email=current_user.email
    respond_to do |format|
      if @jobapplication.update(jobapplication_params)
        format.html { redirect_to @jobapplication, notice: 'Jobapplication was successfully updated.' }
        format.json { render :show, status: :ok, location: @jobapplication }
      else
        format.html { render :edit }
        format.json { render json: @jobapplication.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobapplications/1
  # DELETE /jobapplications/1.json
  def destroy
    @jobapplication.destroy
    respond_to do |format|
      format.html { redirect_to jobapplications_url, notice: 'Jobapplication was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_jobapplication
      @jobapplication = Jobapplication.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def jobapplication_params
      params.require(:jobapplication).permit(:name, :email, :job_name, :phone, :status, :user_id, :job_id, :coverletter, :major)
    end
end
