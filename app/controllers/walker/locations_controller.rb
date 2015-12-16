class Walker::LocationsController < ApplicationController

  def index
    @location = Location.find(1)
  end

  private

end
