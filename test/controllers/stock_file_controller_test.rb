require 'test_helper'

class StockFileControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get stock_file_index_url
    assert_response :success
  end

  test "should get new" do
    get stock_file_new_url
    assert_response :success
  end

end
