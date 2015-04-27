json.array!(@jobapplications) do |jobapplication|
  json.extract! jobapplication, :id, :name, :email, :job_name, :phone, :status, :user_id, :job_id, :coverletter, :major
  json.url jobapplication_url(jobapplication, format: :json)
end
