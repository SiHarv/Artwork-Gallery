require "test_helper"

class ArtworksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get artworks_index_url
    assert_response :success
  end
end
