class Car < ApplicationRecord
  has_many :reservations
  validates :license_plate_number, uniqueness: true, numericality:true , presence: true , length: {is: 7}
  validates :model, presence: true
  validates :manufacturer, presence: true
  validates :hourly_rental_rate, presence: true, numericality:true
  validates :location, presence: true
  validates :style , presence: true
  validates :status ,presence: true, inclusion: { in: %w(Available Checkedout Reserved),
                                                 message: "%{value} is not a valid status"}
  def self.search(search_term)
    if search_term
      self.where(["manufacturer like ? or model like ? or style like ? or location like ? or status like ?",
                  "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%"])
    else
      self.all
    end
  end
end
