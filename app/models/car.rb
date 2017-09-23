class Car < ApplicationRecord
  validates :license_plate_number, uniqueness: true, numericality:true , presence: true , length: {is: 7}
  validates :model, presence: true
  validates :manufacturer, presence: true
  validates :hourly_rental_rate, presence: true, numericality:true
  validates :location, presence: true
  validates :style , presence: true
  validates :status ,presence: true, inclusion: { in: %w(Available Checkedout Reserved),
                                                 message: "%{value} is not a valid status"}
end
