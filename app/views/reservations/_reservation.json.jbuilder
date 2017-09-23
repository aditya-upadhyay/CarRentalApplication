json.extract! reservation, :id, :checkout_time, :return_time, :customer_id, :car_id, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)
