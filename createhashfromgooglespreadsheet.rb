# This script reads a simple table in a google spreadsheet and transforms it to....
# [another comment line]

require 'rubygems'
require 'roo'

puts "starting program..."

# Create an object that represents an open Google spreadsheet
mygooglein  = Google.new("0Au1suE-2JTzEdFFmZHJqckpSVzhBUEFodVdybF9iQkE","danfanderson@gmail.com","Regina02")


# Create an array (of lines or strings) to store the output of the transformation
myoutput = Array.new
# Create an array to store the keys of the hash
mykeys = Array.new

# Starting with Row 1 grab each row and create a string where each Google spreadsheet cell is delimted by a bar '|'

puts "reading the input google doc..."

# Assume hash keys are in the first row (are headers)
mykeys = mygooglein.row(1)
puts "FYI: the number of keys read in are: #{mykeys.length}"
puts "FYI: the actual keys are: #{mykeys.inspect}"

# Iterate from the second row to the last row in the Google spreadsheet
2.upto(mygooglein.last_row) do |line|
  myrow = mygooglein.row(line)
  embeddedquote = '"'
  myoutputstr = "{"                                         # insert the starting bracket to start the hash
  
  mykeys.each_index do |i|
    myoutputstr = myoutputstr + embeddedquote + mykeys[i] + embeddedquote + "=>" + embeddedquote + myrow[i] + embeddedquote + ","
  end
  
  myoutputstr.chop!                                         # remove the last comma "," which is extraneous
  myoutputstr = myoutputstr + "}"                           # add the ending bracket to close the hash
  
  myoutput.push(myoutputstr)                                # add the output string to the output array
  
end 

# Write out the output stored the output array
myoutput.each do |line|
  puts line
end

puts "end of program"