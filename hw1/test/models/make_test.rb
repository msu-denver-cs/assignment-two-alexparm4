require 'test_helper'

class MakeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

   #Source for tests: 18-20 slides from presentation 09Test
  test "should not allow for one character name" do
    s = Make.create({:name => "a", :country => "USA"})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["is too short (minimum is 2 characters)"]},
      s.errors.messages)
  end
  
  test "should not allow for empty name" do
    s = Make.create({:name => "", :country => "USA"})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["is too short (minimum is 2 characters)"]},
      s.errors.messages)
  end

  test "should not allow for nonunique names" do
    t = Make.create({:name => "Camry", :country => "Japan"})
    s = Make.create({:name => "Camry", :country => "Japan"})
    refute s.valid?
    refute s.save
    assert_equal({:name=>["has already been taken"]},
      s.errors.messages)
  end

  test "should not allow for less than 3 character country" do
    s = Make.create({:name => "aa", :country => "US"})
    refute s.valid?
    refute s.save
    assert_equal({:country=>["is too short (minimum is 3 characters)"]},
      s.errors.messages)
  end

  test "should not allow for empty country" do
    s = Make.create({:name => "aa", :country => ""})
    refute s.valid?
    refute s.save
    assert_equal({:country => ["is too short (minimum is 3 characters)"]},
      s.errors.messages)
  end

  test "should not allow for empty name and empty country" do
    s = Make.create({:name => "", :country => ""})
    refute s.valid?
    refute s.save
    assert_equal({:name => ["is too short (minimum is 2 characters)"], :country => ["is too short (minimum is 3 characters)"]},
      s.errors.messages)
  end

  test "should allow acceptable make to be valid" do
    s = Make.create({:name => "Camry", :country => "Japan"})
    assert s.valid?
    assert s.save
  end
end
