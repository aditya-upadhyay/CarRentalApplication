class Admin < ApplicationRecord
  validates_uniqueness_of :email
end
