require "application_system_test_case"

class MakesTest < ApplicationSystemTestCase
  setup do
    @make = makes(:one)
  end

  test "visiting the index" do
    visit makes_url
    assert_selector "h1", text: "Makes"
     #Added assertions, citation: Slide 31 from 09Test slideset
     assert_selector "td", text: makes(:one).name
     assert_selector "td", text: makes(:one).country
  end

  test "creating a Make" do
    visit makes_url
    click_on "New Make"

    fill_in "Country", with: @make.country
    fill_in "Name", with: "NewName"     #Changed to pass selenium tests, to fit unique validation necessary for make name
    click_on "Create Make"

    assert_text "Make was successfully created"
    click_on "Back"
  end

  test "updating a Make" do
    visit makes_url
    click_on "Edit", match: :first

    fill_in "Country", with: @make.country
    fill_in "Name", with: "NameNew"  #Changed to pass selenium tests, to fit unique validation necessary for make name
    click_on "Update Make"

    assert_text "Make was successfully updated"
    click_on "Back"
  end

  #Added missing make name in search test, citation: Slide 32 from 09Test slideset
  test "missing make name in search" do
    visit makes_url
    fill_in "query", with: "Banana"
    click_on "Search"
    refute_selector "td"
  end

  #Added missing make country in search test, citation: Slide 32 from 09Test slideset
  test "missing make country in search" do
    visit makes_url
    fill_in "query", with: "Bananastand"
    click_on "Search"
    refute_selector "td"
  end

  #Added found make name in search test, citation: Slide 32 from 09Test slideset
  test "found make name in search" do
    visit makes_url
    fill_in "query", with: "MyString"
    click_on "Search"
    assert_selector "td", text: "MyString"
  end

  #Added found make name in search test, citation: Slide 32 from 09Test slideset
  test "found make country in search" do
    visit makes_url
    fill_in "query", with: "Japan"
    click_on "Search"
    assert_selector "td", text: "Japan"
  end

  test "destroying a Make" do
    visit makes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Make was successfully destroyed"
  end
end
