require 'test_helper'

class MachinesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get machines_path
    assert_response :success
  end

  test "should get new" do
    get new_machine_path
    assert_response :success
  end

  test "should get edit" do
    get edit_machine_path(1)
    assert_response :success
  end

  test "should get show" do
    get machine_path(1)
    assert_response :success
  end

end
