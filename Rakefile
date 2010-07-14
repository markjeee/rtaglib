#!/usr/bin/ruby
# -*- ruby -*-
require 'rake/testtask'
require 'rake/rdoctask'
require 'rubygems'
require 'fileutils'
require 'hoe'
$:.unshift("./ext")
$:.unshift("./lib")




taglib_source="taglib_#{RUBY_PLATFORM}.source"
desc "compile and test"
task :default => [:compile, :test]


BASE_TAGFILE=File.dirname(__FILE__)+"/ext/tagfile"
BASE_TAGLIB=File.dirname(__FILE__)+"/ext/taglib"



file "#{BASE_TAGFILE}/tagfile.so" => ["#{BASE_TAGFILE}/tagfile.c", "#{BASE_TAGFILE}/Rakefile.rb"] do |t|
	system %(cd "#{BASE_TAGFILE}" && rake)
end

file "#{BASE_TAGLIB}/TagLib.so" => ["#{BASE_TAGLIB}/#{taglib_source}", "#{BASE_TAGLIB}/rake_ext_conf.rb", "#{BASE_TAGLIB}/Rakefile.rb"] do |t|
	system %(cd "#{BASE_TAGLIB}" && rake)
end

if system %(which swig)
    file "#{BASE_TAGLIB}/#{taglib_source}" => ["swig/taglib.i", "swig/rake_ext_conf.rb", "swig/Rakefile"] do |t|
    system %{cd swig && rake}
    end
end

file "lib/TagLib_doc.rb" => "swig/TagLib_doc.rb" do |t|
    system %(cd swig && rake copy)
end

desc "compile the extensions"
task :compile => ["#{BASE_TAGFILE}/tagfile.so","#{BASE_TAGLIB}/TagLib.so"]

task :clean do |t|
	FileUtils.rm_rf("pkg")
	FileUtils.rm_rf("doc")
	[BASE_TAGFILE, BASE_TAGLIB,"swig"].each{|dir|
		system %(cd #{dir} && rake clean)
	}
end

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = "doc/html"
  rdoc.main = "README.txt"
  rdoc.rdoc_files=["README.txt", "ext/tagfile/tagfile.c", "lib/TagLib_doc.rb"]
end

task :svn => [:default] do |t|
    system %(cd #{File.dirname(__FILE__)})
    system %(svn commit)
    system %(svn cp svn+ssh://clbustos@rubyforge.org/var/svn/rtaglib/trunk/ svn+ssh://clbustos@rubyforge.org/var/svn/rtaglib/tags/rtaglib-#{TagLib::VERSION} -m "Tag for rtaglib-#{TagLib::VERSION}")    
end


require 'TagLib'
Hoe.spec 'rtaglib' do |p|

p.name="rtaglib"
p.version=TagLib::VERSION
  p.developer('cdx', 'clbustos@gmail.com')
  p.summary="Bindings for taglib"
  p.description= <<-EOF
  Rtaglib is a binding for Taglib's library (http://developer.kde.org/~wheeler/taglib.html).
      TagFile uses the same interface of ruby-taglib, but creates a true ruby extension.
      Taglib is a complete implementation of the Api, based on swig. See test/test_taglib.rb for examples of use
EOF
#p.requirements << "libtag >=1.4"
#	s.required_ruby_version = '>= 1.8.0'
#	s.platform = Gem::Platform::RUBY
p.url = "http://rtaglib.rubyforge.org/"
p.test_globs=['test/test_*.rb']
p.remote_rdoc_dir = '' # Release to root
#p.rdoc_pattern=/(lib\/TagLib_doc.rb|ext\/tagfile\/.*\.c|\.txt)/
#p.clean_globs = ['ext/taglib/*.log','ext/taglib/*.o','ext/taglib/*.so', 'ext/tagfile/*.log','ext/tagfile/*.o','ext/tagfile/*.so']
#p.platform = Gem::Platform::RUBY
p.spec_extras= {'requirements'=>'libtag >=1.5', 'extensions' => ["ext/Rakefile"]}
end
# vim: syntax=Ruby
