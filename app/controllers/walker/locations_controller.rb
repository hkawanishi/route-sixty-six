class Walker::LocationsController < ApplicationController

  def index
    @latlngdata = SmarterCSV.process('/assets/csv/route66_start1.csv')
    #@locations = Location.all
    #@hash = Gmaps4rails.build_markers(@locations) do |location, marker|

  end

  private

end
