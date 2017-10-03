class Reservation < ApplicationRecord

  validates :return_time, presence: true
  validates :checkout_time, presence: true
  validate :checkout_date_cannot_be_in_the_past
  validate :seven_day_booking
  validate :booking_span
  validate :return_after_booking


  belongs_to :customer
  belongs_to :car

  def self.find_user_reservation(user_id)
    self.where(["customer_id = ?",user_id]).where(car_id: Car.where(status:["Checkedout","Reserved"])).first
  end

  def self.find_by_customer(user_id)
      self.where(["customer_id = ?", user_id])
  end

  def checkout_date_cannot_be_in_the_past
    if checkout_time.to_date< Date.today
      errors.add(:checkout_time, "can't be in the past")
    end
  end
  def seven_day_booking
    difference_in_days = (checkout_time.to_date - Date.current).to_i
    if difference_in_days>7
      errors.add(:checkout_time, "Booking is allowed only 7 days in advance")
    end
  end
  def booking_span
    difference_in_days = (return_time - checkout_time).to_i
    if difference_in_days==0
      difference_in_time = (return_time.to_time-checkout_time.to_time).to_i
      if difference_in_time >10
       errors.add(:return_time, "- Car can be checkedout only for 10 hours")
      else
      if difference_in_time<1
        errors.add(:return_time, "- Minimum reservation time is 1 hour")
      end
      end
    end
  end
  def return_after_booking
  end
end
