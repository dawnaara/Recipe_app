json.extract! rating, :id, :stars, :user_id, :recipe_id, :created_at, :updated_at
json.url rating_url(rating, format: :json)