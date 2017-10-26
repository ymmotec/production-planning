require 'test_helper'

class OpenOrderFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get open_order_files_new_url
    assert_response :success
  end

end
