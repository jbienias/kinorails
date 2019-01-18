require "application_system_test_case"

class FavouriteMoviesTest < ApplicationSystemTestCase
  setup do
    @favourite_movie = favourite_movies(:one)
  end

  test "visiting the index" do
    visit favourite_movies_url
    assert_selector "h1", text: "Favourite Movies"
  end

  test "creating a Favourite movie" do
    visit favourite_movies_url
    click_on "New Favourite Movie"

    fill_in "Movie", with: @favourite_movie.movie_id
    fill_in "User", with: @favourite_movie.user_id
    click_on "Create Favourite movie"

    assert_text "Favourite movie was successfully created"
    click_on "Back"
  end

  test "updating a Favourite movie" do
    visit favourite_movies_url
    click_on "Edit", match: :first

    fill_in "Movie", with: @favourite_movie.movie_id
    fill_in "User", with: @favourite_movie.user_id
    click_on "Update Favourite movie"

    assert_text "Favourite movie was successfully updated"
    click_on "Back"
  end

  test "destroying a Favourite movie" do
    visit favourite_movies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Favourite movie was successfully destroyed"
  end
end
