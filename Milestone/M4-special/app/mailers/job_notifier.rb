class JobNotifier < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.job_notifier.received.subject
  #
  def received(jobapplication)
    @jobapplication=jobapplication
    @job=Job.find_by_name(jobapplication.job_name)
    @em_email=@job.employer.email
    @greeting = "Greetings!"
    mail to:  @em_email,subject: 'Application Received'
  end
  def stupdated(jobapplication)
    @jobapplication=jobapplication
    @job=Job.find_by_name(jobapplication.job_name)
    @greeting = "Greetings!"
    mail to:  jobapplication.email,subject: 'Application Status has been Updated'
  end
end
