class Customer < ApplicationRecord
  has_many :reservations
  validates :email, uniqueness: true, presence: true
  after_initialize :init

  def init
    self.rental_charges ||= 0.0
  end

  #validates :name, presence: true
  # validates :password, presence:true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
