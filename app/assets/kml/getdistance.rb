module GetDistanceFromKML

  def self.read_kml_file
    found = false
    coord_line = ""
    kmlfile = File.open("route66_start1.kml","r")
    kmlfile.readlines.each do |line|
      if (line.include?("coordinates") && (found == false))
        found = true
        coord_line = line 
      end 
    end
    kmlfile.close
    coord_line.delete! "<coordinates>" "/"
    ary = coord_line.split(" ")

    ary_new = []
    ary.each_with_index do |string, index|
      ary_each_string = []
      string.split(",").each do |n|
        ary_each_string << n.to_f
      end
      ary_each_string.unshift(index)
      ary_new << ary_each_string
      
    end
    
    #puts ary_new.inspect
    return ary_new 
  end

  def self.get_distance_between_each_lat_long_ary(lat1,lon1,lat2,lon2)
    earth_radius = 6371 # Radius of the earth in km
    dLat = deg2rad(lat2-lat1)  # deg2rad below
    dLon = deg2rad(lon2-lon1) 
    a = 
        Math.sin(dLat/2) * Math.sin(dLat/2) +
        Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * 
        Math.sin(dLon/2) * Math.sin(dLon/2)
         
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a)) 
    d = earth_radius * c # Distance in km
    return d * 1000 # Convert km to meters in return value
  end

  def self.deg2rad(deg) 
      return deg * (Math::PI/180)
  end
  

  def self.get_distance
    lat_long_ary = read_kml_file()
    csvfile = File.open("route66_start1_new.csv", "w")
    csvfile.write("id,long,lat,alt,dist\n")

    n = 0
    distance_between_lat_long_ary = 0
    while n < lat_long_ary.length
      if n == 0 
        csvfile.write("#{lat_long_ary[n].push(0.0).join(",")}\n")
      else
        distance_between_lat_long_ary =  distance_between_lat_long_ary + get_distance_between_each_lat_long_ary(lat_long_ary[n][2], lat_long_ary[n][1], lat_long_ary[n-1][2], lat_long_ary[n-1][1])
        csvfile.write("#{lat_long_ary[n].push(distance_between_lat_long_ary).join(",")}\n")
      end
      n += 1
    end
    csvfile.close

  end

end

GetDistanceFromKML.get_distance()
