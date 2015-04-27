require 'test_helper'

class JobapplicationsControllerTest < ActionController::TestCase
  fixtures :jobapplications

  # fixtures :authenticate!
  setup do
    @jobapplication = jobapplications(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobapplications)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobapplication" do
    assert_difference('Jobapplication.count') do
      post :create, jobapplication: { coverletter: @jobapplication.coverletter, email: @jobapplication.email, job_id: @jobapplication.job_id, job_name: @jobapplication.job_name, major: @jobapplication.major, name: @jobapplication.name, phone: @jobapplication.phone, status: @jobapplication.status, user_id: @jobapplication.user_id }
    end

    assert_redirected_to jobapplication_path(assigns(:jobapplication))
  end

  test "should show jobapplication" do
    get :show, id: @jobapplication
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jobapplication
    assert_response :success
  end

  test "should update jobapplication" do
    patch :update, id: @jobapplication, jobapplication: { coverletter: @jobapplication.coverletter, email: @jobapplication.email, job_id: @jobapplication.job_id, job_name: @jobapplication.job_name, major: @jobapplication.major, name: @jobapplication.name, phone: @jobapplication.phone, status: @jobapplication.status, user_id: @jobapplication.user_id }
    assert_redirected_to jobapplication_path(assigns(:jobapplication))
  end

  test "should destroy jobapplication" do
    assert_difference('Jobapplication.count', -1) do
      delete :destroy, id: @jobapplication
    end

    assert_redirected_to jobapplications_path
  end
end
