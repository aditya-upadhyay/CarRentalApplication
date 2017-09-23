class Customer < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  # vallidates :password, presence:true
end
