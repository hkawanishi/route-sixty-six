class Walk < ActiveRecord::Base
  belongs_to :user
  belongs_to :usersetting

  validates :step, :presence => true, numericality: { only_integer: true }

end

class CurrentUserSetting

  def self.new_from_user_settings(user_settings)
    @strideunit = user_settings.strideunit
    @distanceunit = user_settings.distanceunit
    @userstride = user_settings.userstride
  end

  def self.new_from_defaults
    new(default_stride, default_stride_unit, default_distance_unit)
  end

  def initialize(userstride, strideunit, distanceunit)
    @userstride = userstride
    @strideunit = strideunit
    @distanceunit = distanceunit
  end

  def step_conversion
    @stepconversion = 1
    if @strideunit == 1 # in inches
      @stepconversion = 0.00001578 * @userstride #convert it to in miles
    else
      @stepconversion = 0.00001578 * 0.3937 * @userstride #convert it to miles
    end
    return @stepconversion
  end

  def distance_conversion
    @distanceconversion = 1
    if @distanceunit == 1 # in mile
      @distanceconversion = 1  # keep it in mile
    else
      @distanceconversion = 1.6093 # convert it ot km
    end
    return @distanceconversion
  end
end
