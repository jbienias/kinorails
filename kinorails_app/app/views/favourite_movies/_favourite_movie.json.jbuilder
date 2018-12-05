json.extract! favourite_movie, :id, :user_id, :movie_id, :created_at, :updated_at
json.url favourite_movie_url(favourite_movie, format: :json)
