json.extract! admin, :id, :email, :password, :role, :created_at, :updated_at
json.url admin_url(admin, format: :json)
