class Location < ActiveRecord::Base
  belongs_to :user
  has_many :walks
  belongs_to :usersetting
  geocoded_by :address
  after_validation :geocode
end
