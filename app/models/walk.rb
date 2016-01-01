class Walk < ActiveRecord::Base
  belongs_to :user
  belongs_to :usersetting

  validates :step, :presence => true, numericality: { only_integer: true }

end

class CurrentUserSetting

  attr_accessor :userstride, :strideunit, :distanceunit

  def self.new_from_user_settings(user_settings)
    new(user_settings[:userstride], user_settings[:strideunit], user_settings[:distanceunit])
  end

  # need to edit this
  def self.new_from_defaults
    new(28, 1, 1)
  end

  def initialize(userstride, strideunit, distanceunit)
    @userstride = userstride
    @strideunit = strideunit
    @distanceunit = distanceunit
  end

  def step_conversion
    @stepconversion = 1
    if @strideunit == 1 # in inches
      @stepconversion = 0.00001578 * @userstride # convert it to in miles
    else
      @stepconversion = 0.00001578 * 0.3937 * @userstride # convert it to miles
    end
    return @stepconversion
  end

  def distance_conversion
    @distanceconversion = 1
    if @distanceunit == 1 # in mile
      @distanceconversion = 1  # keep it in mile
    else
      @distanceconversion = 1.6093 # convert it to km
    end
    return @distanceconversion
  end

end
