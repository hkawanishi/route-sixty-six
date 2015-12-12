class Walker::UsersettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @usersetting = Usersetting.new
  end

  def create
    @usersetting = current_user.usersettings.create(usersetting_params)
    redirect_to walker_usersetting_path(@usersetting)
  end

  def show
    @usersetting = Usersetting.find(params[:id])
  end


  private

  def usersetting_params
    params.require(:usersetting).permit(:userstride, :strideunit, :distanceunit)
  end

end
