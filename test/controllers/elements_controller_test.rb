require 'test_helper'

class ElementsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get elements_path
    assert_response :success
  end

  test "should get show" do
    
    get element_path(1)
    assert_response :success
  end

end
