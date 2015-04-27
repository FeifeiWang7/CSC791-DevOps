require 'test_helper'

class JobpoolControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select 'main .entry', 1
    assert_select '#columns #side', minimun: 1
  end

end
