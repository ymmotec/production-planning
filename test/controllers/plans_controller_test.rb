require 'test_helper'

class PlansControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get plans_index_url
    assert_response :success
  end

  test "should get new" do
    get plans_new_url
    assert_response :success
  end

  test "should get show" do
    get plans_show_url
    assert_response :success
  end

  test "should get edit" do
    get plans_edit_url
    assert_response :success
  end

end
