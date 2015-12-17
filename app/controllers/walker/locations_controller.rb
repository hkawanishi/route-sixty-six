class Walker::LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

  private

end
