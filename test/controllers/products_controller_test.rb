require 'test_helper'


class ProductsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = users(:alice)
    Warden.test_mode!
    login_as(@user, scope: :user)
  end

  test "should get index" do
    # sign_in(:tom)
    get products_path
    assert_response :success
  end

  test "should get new" do
    get new_product_path
    assert_response :success
  end

  test "should get edit" do
    get edit_product_path(1)
    assert_response :success
  end

  test "should get show" do
    product = Product.create(products(:linnmon).attributes)
    get product_path(product.id)
    assert_response :success
  end

end
