require 'test_helper'

class OrderFilesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get new_order_file_path
    assert_response :success
  end

  test "should get index" do
    get order_files_path #order_files_index_url
    assert_response :success
  end

end
