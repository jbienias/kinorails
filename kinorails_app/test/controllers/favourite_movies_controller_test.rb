require 'test_helper'

class FavouriteMoviesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @favourite_movie = favourite_movies(:one)
  end

  test "should get index" do
    get favourite_movies_url
    assert_response :success
  end

  test "should get new" do
    get new_favourite_movie_url
    assert_response :success
  end

  test "should create favourite_movie" do
    assert_difference('FavouriteMovie.count') do
      post favourite_movies_url, params: { favourite_movie: { movie_id: @favourite_movie.movie_id, user_id: @favourite_movie.user_id } }
    end

    assert_redirected_to favourite_movie_url(FavouriteMovie.last)
  end

  test "should show favourite_movie" do
    get favourite_movie_url(@favourite_movie)
    assert_response :success
  end

  test "should get edit" do
    get edit_favourite_movie_url(@favourite_movie)
    assert_response :success
  end

  test "should update favourite_movie" do
    patch favourite_movie_url(@favourite_movie), params: { favourite_movie: { movie_id: @favourite_movie.movie_id, user_id: @favourite_movie.user_id } }
    assert_redirected_to favourite_movie_url(@favourite_movie)
  end

  test "should destroy favourite_movie" do
    assert_difference('FavouriteMovie.count', -1) do
      delete favourite_movie_url(@favourite_movie)
    end

    assert_redirected_to favourite_movies_url
  end
end
