require 'test_helper'

class Com40ControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get com40_index_url
    assert_response :success
  end

  test "should get new" do
    get com40_new_url
    assert_response :success
  end

  test "should get show" do
    get com40_show_url
    assert_response :success
  end

end
