require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

#Needed to update this test to create a car with part_ids as well, to fit into car creation validation added after these tests were generated.
  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { make_id: makes(:one).id, model: "Test Model", vin: "0123456789H12", part_ids: [parts(:one).id] } }
    end

    assert_redirected_to car_url(Car.last)
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

#Needed to update this test to update a car with parts parameter as per the added validations
  test "should update car" do
    patch car_url(@car), params: { car: { make_id: makes(:two).id, model: "TestModel1", vin: "0123456789H12", part_ids: [parts(:one).id] } }
    assert_redirected_to car_url(@car)
  end

  #Test car model name lookup that should fail (Cite: Slide 18, from 09Test)
  test "shouldn't find a missing car model name" do
    assert Car.where("model like ?", "HummerLimo").length == 0
  end

  #Test car VIN lookup that should fail (Cite: Slide 18, from 09Test)
  test "shouldn't find a missing make VIN" do
    assert Car.where("vin like ?", "01010101010101000").length == 0
  end

  #Test car model name lookup that should succeed (Cite: Slide 19, from 09Test)
  test "should find car model name from fixture" do
    assert Car.where("model like ?", "MyString").length == 1
  end

  #Test car vin lookup that should succeed (Cite: Slide 19, from 09Test)
  test "should find car vin from fixture" do
    assert Car.where("vin like ?", "MYSTRING0101010").length == 1
  end

  #Tests status code of arbitrary query to be 200 (Cite: Slide 19, from 09Test)
  test "searches always return 200" do
    get search_cars_url, params: { query: "Test"}
    assert_equal 200, status
  end

  #Tests car model name search that should succeed (Cite: Slide 21, from 09Test)
  test "should find MyString" do
    get search_cars_url, params: { query: "MyString"}
    assert_select 'td', 'MyString'
  end

  #Tests car vin search that should succeed (Cite: Slide 21, from 09Test)
  test "should find MYSTRING0101010" do
    get search_cars_url, params: { query: "MYSTRING0101010"}
    assert_select 'td', 'MYSTRING0101010'
  end

  #Tests car model name search that shouldn't succeed (Cite: Slide 21, from 09Test)
  test "shouldn't find HummerLimo" do
    get search_cars_url, params: { query: "HummerLimo"}
    assert_select 'td', false  
  end
  
  #Tests car vin search that shouldn't succeed (Cite: Slide 21, from 09Test)
  test "shouldn't find 01010101010101000" do
    get search_cars_url, params: { query: "01010101010101000"}
    assert_select 'td', false  
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end
end
