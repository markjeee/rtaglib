= rtaglib

http://rtaglib.rubyforge.org

== DESCRIPTION:

Bindings for taglib (http://developer.kde.org/~wheeler/taglib.html), a library for reading and editing the meta-data of several popular audio formats. 

* TagFile: This class uses the same interface of http://www.hakubi.us/ruby-taglib/.
* TagLib: Recreates the original C++ API using swig.


== FEATURES/PROBLEMS:

Reports problem to clbustos _AT_ gmail.com

== SYNOPSIS:

*TagFile*

	irb(main):001:0> require 'tagfile/tagfile'
	=> true
	irb(main):002:0> tag=TagFile::File.new('saw.mp3')
	=> #<TagFile::File:0xb796d61c>
	irb(main):003:0> tag.title
	=> "Saw"
	irb(main):004:0> tag.artist
	=> "Claudio Bustos"
	irb(main):005:0> tag.album
	=> "Catori"
	irb(main):006:0> tag.genre
	=> "Lo-Fi"
	irb(main):007:0> tag.track
	=> 1
	irb(main):008:0> tag.year
	=> 2005
	irb(main):009:0> tag.comment
	=> "Test for catori"
	irb(main):010:0> 

*TagLib*
	irb(main):001:0> require 'TagLib'
	=> true
	irb(main):002:0> fr=TagLib::FileRef.new('440Hz-5sec.mp3')
	=> #<TagLib::FileRef:0x7f3d044e73c8>
	irb(main):003:0> fr.tag
	=> #<TagLib::Tag:0x7f3d044e4768>
	irb(main):004:0> fr.audioProperties
	=> #<TagLib::AudioProperties:0x7f3d044e14a0>
	irb(main):005:0> fr.tag.title
	=> "440Hz Sine Wave"


== REQUIREMENTS:

* taglib >= 1.5

URL: http://developer.kde.org/~wheeler/taglib.html

== INSTALL:

sudo gem install rtaglib

== LICENSE:

GPL V2