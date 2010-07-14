begin
	require 'rtaglib_mswin32'
	require 'tagfile/tagfile'
rescue LoadError
  $stderr.puts "Warning: tagfile/tagfile not found. This is normal if the extension has not beed build yet"
end
