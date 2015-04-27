json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :content, :field, :tag, :tag_id, :employer_name, :deadline, :employer_id
  json.url job_url(job, format: :json)
end
