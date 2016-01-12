require 'walk'
class Walker::WalksController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.usersetting
      @current_user_setting = CurrentUserSetting.new_from_user_settings(current_user.usersetting)
    else
      @current_user_setting = CurrentUserSetting.new_from_defaults
    end
    #@stepconversion = step_conversion
    #@distanceconversion = distance_conversion
    @walks = current_user.walks
    csvfile = File.join(Rails.root, '/app/assets/kml/', 'route66_complete.csv')
    #@map_html = File.join(Rails.root, '/app/views/walker/walks/', 'map.html.erb')
    # import csv files as arrays of hashes
    @latlngdata = SmarterCSV.process(csvfile)
  end

  #def index
  #  @usersettings = current_user.usersettings.last
  #  @walks = current_user.walks
  #  unit_conversion()
  #end

  def new
    @walk = Walk.new
  end

  def create
    @walk = current_user.walks.create(walk_params)
    if @walk.valid?
      redirect_to walker_walks_path
    else
      render :new, :status => :unprocessable_entry
    end
  end

  def destroy
    @walk = Walk.find(params[:id])
    @walk.destroy

    redirect_to walker_walks_path
  end

  private

  def walk_params
    params.require(:walk).permit(:date, :step)
  end


end
