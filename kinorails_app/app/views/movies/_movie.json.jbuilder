json.extract! movie, :id, :title, :director, :country_of_origin, :length, :poster_link, :description, :created_at, :updated_at
json.url movie_url(movie, format: :json)
