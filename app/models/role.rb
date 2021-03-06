class Role < ActiveRecord::Base
  has_many :role_assignments
  has_many :users, through: :role_assignments

  validates :name, presence: true, uniqueness: true

  def to_label
    name
  end
end
