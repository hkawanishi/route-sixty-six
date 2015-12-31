class Walker::LocationsController < ApplicationController

  def index
    csvfile = File.join(Rails.root, '/app/assets/kml/', 'route66_start1_new.csv')
    #@latlngdata = SmarterCSV.process("/vagrant/src/route66/app/assets/csv/route66_start1.csv")
    @latlngdata = SmarterCSV.process(csvfile)
    #@locations = Location.all

  end

  private

end
