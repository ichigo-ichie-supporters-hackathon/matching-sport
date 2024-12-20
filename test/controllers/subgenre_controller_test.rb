require "test_helper"

class SubgenreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get subgenre_index_url
    assert_response :success
  end
end
