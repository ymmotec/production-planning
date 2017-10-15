require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get orders_path
    assert_response :success
  end

end
