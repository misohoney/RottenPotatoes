json.extract! review, :id, :movie_id, :user_name, :user_email, :rating, :comment, :created_at, :updated_at
json.url review_url(review, format: :json)
