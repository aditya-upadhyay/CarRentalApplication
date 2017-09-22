class Admin < ApplicationRecord
  validates_uniqueness_of :email
  validates :name, presence: true

end
