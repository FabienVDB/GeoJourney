require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get uptade" do
    get favorites_uptade_url
    assert_response :success
  end
end
