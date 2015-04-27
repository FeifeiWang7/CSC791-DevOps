FactoryGirl.define do
  factory :job do
    name "Software Engineer"
    content "MyText"
    field "Computer Science"
    tag "CS,SW"
    tag_id 1
    employer_name "Google"
    deadline "2015-08-19"
    employer_id 1
    created_at "2015-04-19"
    updated_at "2015-04-19"
  end
end
