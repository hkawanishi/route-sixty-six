class Usersetting < ActiveRecord::Base
  belongs_to :user
  has_many :walks

  validates :userstride, :presence => true, numericality: { only_integer: true }
end
