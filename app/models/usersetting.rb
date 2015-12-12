class Usersetting < ActiveRecord::Base
  belongs_to :user
  has_many :walks
end
