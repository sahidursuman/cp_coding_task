json.extract! recipe, :id, :user_id, :country, :external, :photo, :published_at, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
