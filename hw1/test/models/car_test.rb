require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #Source for tests: 18-20 slides from presentation 09Test
  test "should not allow for empty make" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make_id => nil, :model => "Camry", :vin => "1234567890R", :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:make=>["must exist", "can't be blank"]},
      c.errors.messages)
  end

  test "should not allow for empty parts" do
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => "1234567890G", :part_ids => nil})
    refute c.valid?
    refute c.save
    assert_equal({:parts=>["can't be blank"]},
      c.errors.messages)
  end

  test "should not allow for empty model" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => nil, :vin => "12345678J0G", :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:model=>["is too short (minimum is 2 characters)"]},
      c.errors.messages)
  end

  test "should not allow for too small VIN" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => nil, :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["is too short (minimum is 11 characters)"]},
      c.errors.messages)
  end

  test "should not allow for too large VIN" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => "012345678901234567890", :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["is too long (maximum is 17 characters)"]},
      c.errors.messages)
  end

  test "should not allow for nonalphanumerical VINs" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => "*12031&90312", :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["only accepts upper-case letters and numbers"]},
      c.errors.messages)
  end

  test "should not allow for under-cased letters in VINs" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => "h12031r90312", :part_ids => 1})
    refute c.valid?
    refute c.save
    assert_equal({:vin=>["only accepts upper-case letters and numbers"]},
      c.errors.messages)
  end

  test "should not allow for car with all empty fields" do
    c = Car.create({:make => nil, :model => nil, :vin => nil, :part_ids => nil})
    refute c.valid?
    refute c.save
    assert_equal({:make=>["must exist", "can't be blank"], 
          :parts=>["can't be blank"], 
          :model=>["is too short (minimum is 2 characters)"],  
          :vin=>["is too short (minimum is 11 characters)"]},
      c.errors.messages)
  end
  
  test "should create a valid car" do
    p = Part.create({:name => "Engine", :id => 1})
    c = Car.create({:make => makes(:one), :model => "Camry", :vin => "1234567H90G", :part_ids => 1})
    assert c.valid?
    assert c.save
  end
end
