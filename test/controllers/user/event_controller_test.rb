require "test_helper"

class User::EventControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_event_index_url
    assert_response :success
  end

  test "should get new" do
    get user_event_new_url
    assert_response :success
  end

  test "should get create" do
    get user_event_create_url
    assert_response :success
  end

  test "should get edit" do
    get user_event_edit_url
    assert_response :success
  end

  test "should get update" do
    get user_event_update_url
    assert_response :success
  end
end
