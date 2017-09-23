class Admin < ApplicationRecord
  validates :email , uniqueness: true, presence: true
  validates :name, presence: true

end
