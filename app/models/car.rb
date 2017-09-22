class Car < ApplicationRecord
  validates_uniqueness_of :license_plate_number
end
