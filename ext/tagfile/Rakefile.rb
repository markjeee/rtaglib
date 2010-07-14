require 'rake'
require 'fileutils'

c_file="tagfile.c"
ext_file="tagfile.so"


if RUBY_PLATFORM=~/mswin32/
	task :default => [:compile, :manifest]
else
	task :default => [:compile]
end

task :compile => ["Makefile",  c_file] do |t|
	if RUBY_PLATFORM=~/mswin32/
		system %(nmake)
	else
		system %(make)
	end
end

file "Makefile" => ["rake_ext_conf.rb"] do |t|
	system %(ruby rake_ext_conf.rb)
end


task :manifest => [ext_file, "#{ext_file}.manifest"] do |t|
	system %(mt.exe -manifest #{ext_file}.manifest -outputresource:#{ext_file};2)
end

task :clean do |t|
	%w{so o log exp def}.each{|g|
		Dir.glob("*.#{g}").each {|f|
			FileUtils.rm(f)
		}
	}
	if File.exists? "Makefile"
		system %(make clean)
		system %(nmake clean)
	end	
	FileUtils.rm("Makefile") if File.exists? "Makefile"
end