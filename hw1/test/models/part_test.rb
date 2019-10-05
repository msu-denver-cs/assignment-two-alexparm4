require 'test_helper'

class PartTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #Source for tests: 18-20 slides from presentation 09Test
  test "should not allow for one character name" do
    s = Part.create({:name => "a"})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["is too short (minimum is 2 characters)"]},
      s.errors.messages)
  end
  
  test "should not allow for empty name" do
    s = Part.create({:name => ""})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["is too short (minimum is 2 characters)"]},
      s.errors.messages)
  end

  test "should not allow for nonunique names" do
    t = Part.create({:name => "Engine"})
    s = Part.create({:name => "Engine"})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["has already been taken"]},
      s.errors.messages)
  end

  test "should allow acceptable part to be valid" do
    s = Part.create({:name => "Engine"})
    assert s.valid?
    assert s.save
  end
end
