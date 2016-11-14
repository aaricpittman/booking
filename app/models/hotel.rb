class Hotel < ActiveRecord::Base
  has_many :rooms

  def to_label
    name
  end
end
