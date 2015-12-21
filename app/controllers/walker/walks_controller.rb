#require 'walk'
class Walker::WalksController < ApplicationController
  before_action :authenticate_user!

  #def index
  #  if current_user.usersettings
  #    puts "current user settings is #{current_user.usersettings}"
  #    @current_user_setting = CurrentUserSetting.new_from_user_settings(current_user.usersettings)
  #  else
  #    @current_user_setting = CurrentUserSetting.new_from_defaults
  #  end
  #end

  def index
    #@walks = Walk.all
    # the following line will only display the current user
    #@usersettings = Usersetting.where(user_id: [current_user.id])  # change this like line 8
    #@usersettings = Usersetting.where(user_id: [current_user.id]).last # need .last in the end
    @usersettings = current_user.usersettings.last

    @walks = current_user.walks
    unit_conversion()
  end

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

  private

  def walk_params
    params.require(:walk).permit(:date, :step)
  end

  def unit_conversion
    @current_user_data = Usersetting.where(user_id: [current_user.id]).last
    if @current_user_data.nil?
      @current_user_stride = 28
      @current_user_strideunit = 1
      @current_user_distanceunit = 1
    else
      @current_user_stride = @current_user_data.userstride
      @current_user_strideunit = @current_user_data.strideunit
      @current_user_distanceunit = @current_user_data.distanceunit
    end

    @stepconversion = 1
    @mdistanceconversion = 1

    if @current_user_strideunit == 1 # in inches
      @stepconversion = 0.00001578 * @current_user_stride  #convert it to in miles
    else
      @stepconversion = 0.00001578 * 0.3937 * @current_user_stride #convert it to miles
    end

    if @current_user_distanceunit == 1 # in mile
      @distanceconversion = 1  # keep it in mile
    else
      @distanceconversion = 1.6093 # convert it ot km
    end
    return @stepconversion, @distanconversion
  end

end
