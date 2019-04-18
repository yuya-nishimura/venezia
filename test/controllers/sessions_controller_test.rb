require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get twitter" do
    get sessions_twitter_url
    assert_response :success
  end

end
