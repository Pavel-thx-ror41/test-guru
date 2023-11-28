require "application_system_test_case"

class GistsTest < ApplicationSystemTestCase
  setup do
    @gist = gists(:one)
  end

  test "visiting the index" do
    visit gists_url
    assert_selector "h1", text: "Gists"
  end

  test "creating a Gist" do
    visit gists_url
    click_on "New Gist"

    fill_in "Gist url", with: @gist.gist_url
    fill_in "Question", with: @gist.question_id
    fill_in "User", with: @gist.user_id
    click_on "Create Gist"

    assert_text "Gist was successfully created"
    click_on "Back"
  end

  test "updating a Gist" do
    visit gists_url
    click_on "Edit", match: :first

    fill_in "Gist url", with: @gist.gist_url
    fill_in "Question", with: @gist.question_id
    fill_in "User", with: @gist.user_id
    click_on "Update Gist"

    assert_text "Gist was successfully updated"
    click_on "Back"
  end

  test "destroying a Gist" do
    visit gists_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Gist was successfully destroyed"
  end
end
