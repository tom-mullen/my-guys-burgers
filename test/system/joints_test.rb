require "application_system_test_case"

class JointsTest < ApplicationSystemTestCase
  setup do
    @joint = joints(:one)
  end

  test "visiting the index" do
    visit joints_url
    assert_selector "h1", text: "Joints"
  end

  test "should create joint" do
    visit joints_url
    click_on "New joint"

    fill_in "Name", with: @joint.name
    click_on "Create Joint"

    assert_text "Joint was successfully created"
    click_on "Back"
  end

  test "should update Joint" do
    visit joint_url(@joint)
    click_on "Edit this joint", match: :first

    fill_in "Name", with: @joint.name
    click_on "Update Joint"

    assert_text "Joint was successfully updated"
    click_on "Back"
  end

  test "should destroy Joint" do
    visit joint_url(@joint)
    accept_confirm { click_on "Destroy this joint", match: :first }

    assert_text "Joint was successfully destroyed"
  end
end
