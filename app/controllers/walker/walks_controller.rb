class Walker::WalksController < ApplicationController
  before_action :authenticate_user!

  def index
    @walks = Walk.all
  end

  def new
    @walk = Walk.new
  end

  def create
    @walk = current_user.walks.create(walk_params)
    #redirect_to walker_walk_path(@walk)
    redirect_to walker_walks_path
  end

  #def show
  #  @walk = Walk.find(params[:id])
  #end

  private

  def walk_params
    params.require(:walk).permit(:date, :step)
  end
end
