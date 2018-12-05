json.extract! reservation, :id, :user_id, :screening_id, :identifier, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
