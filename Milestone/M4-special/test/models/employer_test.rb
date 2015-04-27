require 'test_helper'

class EmployerTest < ActiveSupport::TestCase
   test "Employer attributes must not be empty" do
  #   assert true
     employer = Employer.new
     assert employer.invalid?
     assert employer.errors[:email].any?
   end
end
