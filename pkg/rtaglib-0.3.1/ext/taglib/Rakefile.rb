require 'rake'
require 'fileutils'
c_source="taglib_#{RUBY_PLATFORM}.source"
cpp_file="taglib_#{RUBY_PLATFORM}.cxx"

if RUBY_PLATFORM=~/mswin32/
	task :default => [:compile, :manifest]
else
	task :default => [:compile]
end

task :compile => ["Makefile",  cpp_file] do |t|
	if RUBY_PLATFORM=~/mswin32/
		system %(nmake)
	else
		system %(make)
	end
end

file cpp_file => c_source do |t|
	Dir.glob("*.cpp").each {|f|
		FileUtils.rm(f)
	}
	FileUtils.cp(c_source, cpp_file)
end


file "Makefile" => ["rake_ext_conf.rb", cpp_file] do |t|
	system %(ruby rake_ext_conf.rb)
end


task :manifest => ["TagLib.so", "TagLib.so.manifest"] do |t|
	system %(mt.exe -manifest TagLib.so.manifest -outputresource:TagLib.so;2)
end

task :clean do |t|
	%w{so o log exp def cxx}.each{|g|
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