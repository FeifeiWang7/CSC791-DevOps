require 'test_helper'

class JobapplicationTest < ActiveSupport::TestCase
   test "Jobapplication attributes must not be empty" do
  #   assert true
     jobapplication = Jobapplication.new
     assert jobapplication.invalid?
   end
end
