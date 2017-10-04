class Customer < ApplicationRecord
  has_many :reservations, :dependent => :destroy
  validates :email, uniqueness: true, presence: true
  validates :role_check ,presence: true, inclusion: { in: %w(customer admin superadmin),
                                                  message: "%{value} is not a valid user role"}
  after_initialize :init

  def init
    self.rental_charges ||= 0.0
    self.role_check ||= 'customer'
  end

  def self.find_other_admins(id)
    self.where.not(["id = ?", id]).where(["role_check = ?", 'admin'])
  end

  #validates :name, presence: true
  # validates :password, presence:true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
