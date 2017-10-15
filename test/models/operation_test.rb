require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "calculating cycle time" do
    op = Operation.create(name: "test", element_id: Element.first.id, machine_id: Machine.first.id, efficiency_per_shift: 28800)
    assert_equal 1, op.cycle_time
  end
end
