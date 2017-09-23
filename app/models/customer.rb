class Customer < ApplicationRecord
  has_many :reservations
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  # validates :password, presence:true
end
