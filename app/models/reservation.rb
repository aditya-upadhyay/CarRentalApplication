class Reservation < ApplicationRecord

  validates :return_time, presence: true
  validates :checkout_time, presence: true
  validate :checkout_date_cannot_be_in_the_past
  validate :seven_day_booking
  validate :booking_span
  validate :return_after_booking


  belongs_to :customer
  belongs_to :car

  after_initialize :init

  def init
    self.active ||= false
  end

  def self.find_user_reservation(user_id)
    self.where(["customer_id = ? and active = ?",user_id, true]).where(car_id: Car.where(status:["Checkedout","Reserved"])).first
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
    difference_in_time= ((return_time.to_time - checkout_time.to_time).to_i )/60

    puts difference_in_time
    if difference_in_time > 600
      errors.add(:checkout_time, ": Booking span can not be more than 10 hours");
    else
      if difference_in_time <60
        errors.add(:checkout_time, ": Booking span can not be less than 1 hours");
      end
    end
  end
  
  def return_after_booking
    difference_in_time = (return_time.to_time - checkout_time.to_time).to_i
    if(difference_in_time<=0)
      errors.add(:return_time, "should be after checkout time")
    end
  end
end
