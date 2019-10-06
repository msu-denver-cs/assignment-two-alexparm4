require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
     #Added assertions, citation: Slide 31 from 09Test slideset
     assert_selector "td", text: cars(:one).model
     assert_selector "td", text: cars(:one).vin
     #Parts aren't displayed in the index, so no assertion for parts is here
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    select "Toyota", :from => "car_make_id" #Since I'm using dropdown rather than a blank field; added dropdown selenium code
    fill_in "Model", with: @car.model
    fill_in "Vin", with: "01NEW01010101110"  #Added VIN to update as per validations
    check "MyPart"      #Checks the part name, using the part names from parts.yml

    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    select "Toyota", :from => "car_make_id" #Since I'm using dropdown rather than a blank field; added dropdown selenium code
    fill_in "Model", with: @car.model
    fill_in "Vin", with: "01NEW01010101220"
    check "MyPart"      #Checks the part name, using the part names from parts.yml
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  #Added missing car model name in search test, citation: Slide 32 from 09Test slideset
  test "missing car model name in search" do
    visit cars_url
    fill_in "query", with: "Banana"
    click_on "Search"
    refute_selector "td"
  end

  #Added missing car vin in search test, citation: Slide 32 from 09Test slideset
  test "missing car vin in search" do
    visit cars_url
    fill_in "query", with: "HHHHHHHHHHHH"
    click_on "Search"
    refute_selector "td"
  end

  #Added found car model name in search test, citation: Slide 32 from 09Test slideset
  test "found car model name in search" do
    visit cars_url
    fill_in "query", with: "MyString"
    click_on "Search"
    assert_selector "td", text: "MyString"
  end

  #Added found car vin in search test, citation: Slide 32 from 09Test slideset
  test "found car vin in search" do
    visit cars_url
    fill_in "query", with: "MYSTRING0101010"
    click_on "Search"
    assert_selector "td", text: "MYSTRING0101010"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end
