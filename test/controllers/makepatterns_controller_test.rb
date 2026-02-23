require "test_helper"

class MakepatternsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get makepatterns_index_url
    assert_response :success
  end
end
