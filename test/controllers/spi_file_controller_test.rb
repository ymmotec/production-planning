require 'test_helper'

class SpiFileControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get spi_file_new_url
    assert_response :success
  end

  test "should get index" do
    get spi_file_index_url
    assert_response :success
  end

end
