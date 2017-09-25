class Reservation < ApplicationRecord
  belongs_to :customer
  belongs_to :car
  def self.search(search_term)
    if search_term
      self.where(["customer_id like ?",
                  "%#{search_term}%"])
    end
  end
end
