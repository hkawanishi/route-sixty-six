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
    @usersetting = Usersetting.where(user_id: [current_user.id])
    user_step_data()
  end

  def edit
    @usersetting = Usersetting.where(user_id: [current_user.id]).last
    #@current_data = @current_user_data = Usersetting.where(user_id: [current_user.id]).last
  end

  def update
    @usersetting = Usersetting.find(params[:id])
    if @usersetting.update(usersetting_params)
      redirect_to walker_usersettings_path
    else
      #@current_data = @usersetting
      render :edit, :status => :unprocessable_entry
    end
    #@usersetting.update!(usersetting_params)
    #redirect_to walker_usersettings_path

    #if @usersetting.userstride.integer?
    #  @usersetting.update!(usersetting_params)
    #  redirect_to walker_usersettings_path
    #else
    #  render :edit, :status => :unprocessable_entry
    #end
  end

  private

  def usersetting_params
    params.require(:usersetting).permit(:userstride, :strideunit, :distanceunit)
  end

  def user_step_data
    @current_user_data = Usersetting.where(user_id: [current_user.id]).last
    if @current_user_data.present?
      @current_user_stride = @current_user_data.userstride
      @current_user_strideunit = @current_user_data.strideunit
      @current_user_distanceunit = @current_user_data.distanceunit
    end
  end

end
