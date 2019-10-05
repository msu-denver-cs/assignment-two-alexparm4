require "application_system_test_case"

class PartsTest < ApplicationSystemTestCase
  setup do
    @part = parts(:one)
  end

  test "visiting the index" do
    visit parts_url
    assert_selector "h1", text: "Parts"
    #Added assertion, citation: Slide 31 from 09Test slideset
    assert_selector "td", text: parts(:one).name
    
  end

  test "creating a Part" do
    visit parts_url
    click_on "New Part"

    fill_in "Name", with: "Unique New York Part Name"   #Edited to fit unique validation requirements for part name
    click_on "Create Part"

    assert_text "Part was successfully created"
    click_on "Back"
  end

  test "updating a Part" do
    visit parts_url
    click_on "Edit", match: :first

    fill_in "Name", with: "Part Name That Is Unique" #Edited to fit unique validation requirements for part name
    click_on "Update Part"

    assert_text "Part was successfully updated"
    click_on "Back"
  end

  #Added missing part name in search test, citation: Slide 32 from 09Test slideset
  test "missing part in search" do
    visit parts_url
    fill_in "query", with: "Banana"
    click_on "Search"
    refute_selector "td"
  end

  #Added found part name in search test, citation: Slide 32 from 09Test slideset
  test "found part in search" do
    visit parts_url
    fill_in "query", with: "MyPart"
    click_on "Search"
    assert_selector "td", text: "MyPart"
  end

  test "destroying a Part" do
    visit parts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end
    assert_text "Part was successfully destroyed"
  end
end
