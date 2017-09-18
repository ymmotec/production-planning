require 'test_helper'

class ElementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get elements_index_url
    assert_response :success
  end

  test "should get show" do
    get elements_show_url
    assert_response :success
  end

end
