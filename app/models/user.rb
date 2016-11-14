class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bookings
  has_many :role_assignments
  has_many :roles, through: :role_assignments

  def roles_to_sym
    @roles_to_sym ||= roles.pluck(:name).map{|r| r.downcase.gsub(/ /, '_').to_sym }
  end

  def in_role?(r)
    roles_to_sym.include? r
  end

  def to_label
    email
  end
end
