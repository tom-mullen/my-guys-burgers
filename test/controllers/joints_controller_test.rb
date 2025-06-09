require "test_helper"

class JointsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @joint = joints(:one)
  end

  test "should get index" do
    get joints_url
    assert_response :success
  end

  test "should get new" do
    get new_joint_url
    assert_response :success
  end

  test "should create joint" do
    assert_difference("Joint.count") do
      post joints_url, params: { joint: { name: @joint.name } }
    end

    assert_redirected_to joint_url(Joint.last)
  end

  test "should show joint" do
    get joint_url(@joint)
    assert_response :success
  end

  test "should get edit" do
    get edit_joint_url(@joint)
    assert_response :success
  end

  test "should update joint" do
    patch joint_url(@joint), params: { joint: { name: @joint.name } }
    assert_redirected_to joint_url(@joint)
  end

  test "should destroy joint" do
    assert_difference("Joint.count", -1) do
      delete joint_url(@joint)
    end

    assert_redirected_to joints_url
  end
end
