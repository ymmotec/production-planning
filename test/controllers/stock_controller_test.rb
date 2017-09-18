require 'test_helper'

class StockControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get stock_new_url
    assert_response :success
  end

end
