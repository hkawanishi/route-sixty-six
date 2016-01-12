class Walker::UsersettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @usersetting = Usersetting.new
  end

  def create
    #@usersetting = current_user.usersettings.create(usersetting_params)
    @usersetting = Usersetting.new(usersetting_params)
    @usersetting.user_id = current_user.id

    if @usersetting.save
      redirect_to walker_usersetting_path
    else
      render :new, :status => :unprocessable_entry
    end

    #@usersetting = Usersetting.create(usersetting_params)
    #if @usersetting.save
    #  redirect_to walker_usersetting_path
    #else
    #  render 'new'
    #end
  end

  def show
    #@usersetting = Usersetting.find(params[:id])
    #@usersetting = Usersetting.find_by(user_id: [current_user.id])
    find_current_usersetting
  end

  # no more index page correct?
  #def index
  #  @usersetting = Usersetting.find_by(user_id: [current_user.id])
  #  user_step_data()
  #end

  def edit
    #@usersetting = Usersetting.find_by(user_id: [current_user.id])
    find_current_usersetting

    #@current_data = @current_user_data = Usersetting.where(user_id: [current_user.id]).last
  end

  def update
    #@usersetting = Usersetting.find(params[:id])
    #@usersetting = Usersetting.find_by(user_id: [current_user.id])
    find_current_usersetting
    if @usersetting.update(usersetting_params)
      redirect_to walker_usersetting_path
    else
      render :edit, :status => :unprocessable_entry
    end
  end

  private

  def find_current_usersetting
    @usersetting = Usersetting.find_by(user_id: [current_user.id])
  end

  def usersetting_params
    params.require(:usersetting).permit(:userstride, :strideunit, :distanceunit)
  end

  # no index page, so no need this method
  #def user_step_data
  #  @current_user_data = Usersetting.where(user_id: [current_user.id]).last
  #  if @current_user_data.present?
  #    @current_user_stride = @current_user_data.userstride
  #    @current_user_strideunit = @current_user_data.strideunit
  #    @current_user_distanceunit = @current_user_data.distanceunit
  #  end
  #end

end
