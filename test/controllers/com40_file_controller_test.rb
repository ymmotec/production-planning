require 'test_helper'

class Com40FileControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get com40_file_new_url
    assert_response :success
  end

end
