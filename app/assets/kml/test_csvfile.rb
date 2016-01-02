def test_csvfile

  csv_file = File.open("route66_il_mo.csv", "r") 
  puts csv_file.inspect

  ary_store = []
  csv_file.readlines.each do |line|
    ary = line.split(",")
    if ary[0] != "id"
      ary_store << ary[4].to_f
    end
  end

  i = 1
  another_ary = []
  while i < ary_store.length
    another_ary << (ary_store[i] - ary_store[i-1])
    i += 1
  end

  largest = 0
  ind = 0
  another_ary.each_with_index do |f, index|
    if f > largest
      largest = f
      ind = index
    end
  end
    
  puts largest
  puts ind
    
  csv_file.close

end

test_csvfile



