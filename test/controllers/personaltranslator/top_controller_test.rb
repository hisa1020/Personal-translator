require "test_helper"

class Personaltranslator::TopControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get personaltranslator_top_index_url
    assert_response :success
  end
end
