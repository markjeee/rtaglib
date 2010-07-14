begin
  require 'rtaglib_mswin32'
  require 'taglib/TagLib'
rescue LoadError
  $stderr.puts "Warning: taglib/TagLib not found. This is normal if the extension has not beed build yet"
end

module TagLib
  VERSION = "0.3.1"
end