class Walker::UsersettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @usersetting = Usersetting.new
  end

  def create
    @usersetting = current_user.usersettings.create(usersetting_params)
    redirect_to walker_usersettings_path
  end

  def show
    @usersetting = Usersetting.find(params[:id])
  end

  def index
    @usersettings = Usersetting.where(user_id: [current_user.id])
    user_step_data()
  end

  private

  def usersetting_params
    params.require(:usersetting).permit(:userstride, :strideunit, :distanceunit)
  end

  def user_step_data
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
  end

end
