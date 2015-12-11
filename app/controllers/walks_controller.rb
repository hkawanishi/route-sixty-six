class WalksController < ApplicationController
  before_action :authenticate_user!

  def index
    @walks = Walk.all
  end

  def new
    @walks = Walk.new
  end

  def create
    current_user.walks.create(walk_params)
    redirect_to walks_path
  end

  #  def show
  #    @walk = Walk.all
  #  end

  private

  def walk_params
    params.require(:walk).permit(:date, :step)
  end
end
