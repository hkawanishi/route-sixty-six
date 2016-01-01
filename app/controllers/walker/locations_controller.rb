require 'walk'
class Walker::LocationsController < ApplicationController

  def index
    csvfile = File.join(Rails.root, '/app/assets/kml/', 'route66_start1_new.csv')
    #@latlngdata = SmarterCSV.process("/vagrant/src/route66/app/assets/csv/route66_start1.csv")
    @latlngdata = SmarterCSV.process(csvfile)
    #@locations = Location.all
    if current_user.usersetting
      @current_user_setting = CurrentUserSetting.new_from_user_settings(current_user.usersetting)
    else
      @current_user_setting = CurrentUserSetting.new_from_defaults
    end
    @walks = current_user.walks

  end

  private

end
