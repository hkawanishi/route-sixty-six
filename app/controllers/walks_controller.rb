class WalksController < ApplicationController

  def index
    @walks = Walk.all
  end

  def new
    @walks = Walk.new
  end

  def create
    Walk.create(walk_params)
    redirect_to walks_path
  end

  #  def show
  #    @walk = Walk.all
  #  end

  #  private

  def walk_params
    params.require(:walk).permit(:date, :step)
  end
end
