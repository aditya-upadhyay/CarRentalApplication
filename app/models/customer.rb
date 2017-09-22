class Customer < ApplicationRecord
  validates_uniqueness_of :email
end
