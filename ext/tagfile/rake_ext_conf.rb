require 'mkmf'
puts "Building for #{PLATFORM}"
if(PLATFORM=~/mswin32/)
	package_dir=File.expand_path(File.dirname(__FILE__)+"/..")	
	prefix=package_dir+"/taglib/taglib-mswin32"
	puts "Building for MsWin32"
	$CFLAGS+= " -I\"#{prefix}\\include\" -I\"#{prefix}\\include\\taglib\""
        $LDFLAGS += " -link -libpath:\"#{prefix}\\lib\" "

elsif(PLATFORM=~/mingw/)
	puts "Building for MinGW"
	$libs = append_library($libs, "stdc++")
	$libs = append_library($libs, "supc++")
	$CFLAGS= " -I/mingw/include/taglib"
else
    taglib_config = find_executable("taglib-config")
    if taglib_config
        prefix = `#{taglib_config} --prefix`.strip
        $CFLAGS += " -I#{prefix}/include"
        $LDFLAGS += " -L#{prefix}/lib"
    else
        prefix = "/usr"
	end
	$libs = append_library($libs, "supc++")
    $CFLAGS += " -I#{prefix}/include/taglib"
end
if have_library("tag_c")
    create_makefile("tagfile")
end
