require "test_helper"

class Api::LocalPlanStepsControllerTest < ActionDispatch::IntegrationTest
  test "should get index_by_robot" do
    get api_local_plan_steps_index_by_robot_url
    assert_response :success
  end

  test "should get create" do
    get api_local_plan_steps_create_url
    assert_response :success
  end

  test "should get update" do
    get api_local_plan_steps_update_url
    assert_response :success
  end

  test "should get delete" do
    get api_local_plan_steps_delete_url
    assert_response :success
  end
end
