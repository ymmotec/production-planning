require 'test_helper'

class ProductFamiliesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get product_families_index_url
    assert_response :success
  end

  test "should get new" do
    get product_families_new_url
    assert_response :success
  end

  test "should get show" do
    get product_families_show_url
    assert_response :success
  end

end
