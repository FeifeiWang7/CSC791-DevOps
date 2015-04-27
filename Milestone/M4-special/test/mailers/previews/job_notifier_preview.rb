# Preview all emails at http://localhost:3000/rails/mailers/job_notifier
class JobNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/job_notifier/received
  def received
    JobNotifier.received
  end
  def stupdated
    JobNotifier.stupdated
  end
end
