class Walker::UsersettingsController < ApplicationController
  before_action :authenticate_user!

  def new
    @usersetting = Usersetting.new
  end

  def create
    @usersetting = Usersetting.new(usersetting_params)
    @usersetting.user_id = current_user.id

    if @usersetting.save
      redirect_to walker_usersetting_path
    else
      render :new, :status => :unprocessable_entry
    end
  end

  def show
    find_current_usersetting
  end

  def edit
    find_current_usersetting

  end

  def update
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


end
