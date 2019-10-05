require 'test_helper'

class MakesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @make = makes(:one)
  end

  test "should get index" do
    get makes_url
    assert_response :success
  end

  test "should get new" do
    get new_make_url
    assert_response :success
  end

  test "should create make" do      #Needed to update this test to pass, after changing validations for make
    assert_difference('Make.count') do
      post makes_url, params: { make: {name: "Test", country: "Japan" } }
    end

    assert_redirected_to make_url(Make.last)
  end

  test "should show make" do
    get make_url(@make)
    assert_response :success
  end

  test "should get edit" do
    get edit_make_url(@make)
    assert_response :success
  end

  test "should update make" do
    patch make_url(@make), params: { make: { country: @make.country, name: @make.name } }
    assert_redirected_to make_url(@make)
  end

  #Test make name lookup that should fail (Cite: Slide 18, from 09Test)
  test "shouldn't find a missing make name" do
    assert Make.where("name like ?", "Captain Planet").length == 0
  end

  #Test make country lookup that should fail (Cite: Slide 18, from 09Test)
  test "shouldn't find a missing make country" do
    assert Make.where("country like ?", "Afghanistansuela").length == 0
  end

  #Test make name lookup that should succeed (Cite: Slide 19, from 09Test)
  test "should find make name from fixture" do
    assert Make.where("name like ?", "MyString").length == 1
  end

  #Tests make country lookup that should succeed (Cite: Slide 19, from 09Test)
  test "should find make country from fixture" do
    assert Make.where("country like ?", "Japan").length == 1
  end

  #Tests status code of arbitrary query to be 200 (Cite: Slide 19, from 09Test)
  test "searches always return 200" do
    get search_makes_url, params: { query: "Test"}
    assert_equal 200, status
  end

  #Tests make name search that should succeed (Cite: Slide 21, from 09Test)
  test "should find MyString" do
    get search_makes_url, params: { query: "MyString"}
    assert_select 'td', 'MyString'
  end

  #Tests make country search that should succeed (Cite: Slide 21, from 09Test)
  test "should find Japan" do
    get search_makes_url, params: { query: "Japan"}
    assert_select 'td', 'Japan'
  end

  #Tests make name search that shouldn't succeed (Cite: Slide 21, from 09Test)
  test "shouldn't find Banana" do
    get search_makes_url, params: { query: "Banana"}
    assert_select 'td', false  
  end
  
  #Tests make country search that shouldn't succeed (Cite: Slide 21, from 09Test)
  test "shouldn't find Afghanistansuela" do
    get search_makes_url, params: { query: "Afghanistansuela"}
    assert_select 'td', false  
  end

  test "should destroy make" do
    assert_difference('Make.count', -1) do
      delete make_url(@make)
    end

    assert_redirected_to makes_url
  end
end
