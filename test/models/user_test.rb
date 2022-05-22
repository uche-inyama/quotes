require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "name" do
    assert_equal "", users(:accountant).name
  end
end
