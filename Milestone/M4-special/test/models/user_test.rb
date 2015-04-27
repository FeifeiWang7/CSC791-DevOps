require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "User attributes must not be empty" do

    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?

   end
end
