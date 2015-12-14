class Walk < ActiveRecord::Base
  belongs_to :user
  belongs_to :usersetting

  validates :step, :presence => true, numericality: { only_integer: true }

end
