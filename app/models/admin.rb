class Admin < ApplicationRecord
  validates :email , uniqueness: true, presence: true


end
