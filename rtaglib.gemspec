# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rtaglib}
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Josh Nichols"]
  s.date = %q{2010-07-17}
  s.description = %q{}
  s.email = %q{claudio@icoretech.org}
  s.extra_rdoc_files = [
    "README.txt"
  ]
  s.files = [
    "History.txt",
     "Manifest.txt",
     "README.txt",
     "Rakefile",
     "VERSION",
     "data/440Hz-5sec.flac",
     "data/440Hz-5sec.mp3",
     "data/440Hz-5sec.mpc",
     "data/440Hz-5sec.ogg",
     "data/440Hz-5sec.wv",
     "data/test_jason.mp3",
     "data/test_jason.ogg",
     "ext/Rakefile",
     "ext/tagfile/Rakefile.rb",
     "ext/tagfile/rake_ext_conf.rb",
     "ext/tagfile/tagfile.c",
     "ext/taglib/Rakefile.rb",
     "ext/taglib/rake_ext_conf.rb",
     "ext/taglib/taglib-mswin32/bin/tag.dll",
     "ext/taglib/taglib-mswin32/bin/tag_c.dll",
     "ext/taglib/taglib-mswin32/bin/tag_cd.dll",
     "ext/taglib/taglib-mswin32/bin/tagd.dll",
     "ext/taglib/taglib-mswin32/bin/taglib-config",
     "ext/taglib/taglib-mswin32/include/taglib/apefooter.h",
     "ext/taglib/taglib-mswin32/include/taglib/apeitem.h",
     "ext/taglib/taglib-mswin32/include/taglib/apetag.h",
     "ext/taglib/taglib-mswin32/include/taglib/attachedpictureframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/audioproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/commentsframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/fileref.h",
     "ext/taglib/taglib-mswin32/include/taglib/flacfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/flacproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/generalencapsulatedobjectframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v1genres.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v1tag.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2extendedheader.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2footer.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2frame.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2framefactory.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2header.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2synchdata.h",
     "ext/taglib/taglib-mswin32/include/taglib/id3v2tag.h",
     "ext/taglib/taglib-mswin32/include/taglib/mpcfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/mpcproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/mpegfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/mpegheader.h",
     "ext/taglib/taglib-mswin32/include/taglib/mpegproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/oggfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/oggflacfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/oggpage.h",
     "ext/taglib/taglib-mswin32/include/taglib/oggpageheader.h",
     "ext/taglib/taglib-mswin32/include/taglib/relativevolumeframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/speexfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/speexproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/tag.h",
     "ext/taglib/taglib-mswin32/include/taglib/tag_c.h",
     "ext/taglib/taglib-mswin32/include/taglib/taglib.h",
     "ext/taglib/taglib-mswin32/include/taglib/taglib_export.h",
     "ext/taglib/taglib-mswin32/include/taglib/tbytevector.h",
     "ext/taglib/taglib-mswin32/include/taglib/tbytevectorlist.h",
     "ext/taglib/taglib-mswin32/include/taglib/textidentificationframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/tfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/tlist.h",
     "ext/taglib/taglib-mswin32/include/taglib/tlist.tcc",
     "ext/taglib/taglib-mswin32/include/taglib/tmap.h",
     "ext/taglib/taglib-mswin32/include/taglib/tmap.tcc",
     "ext/taglib/taglib-mswin32/include/taglib/trueaudiofile.h",
     "ext/taglib/taglib-mswin32/include/taglib/trueaudioproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/tstring.h",
     "ext/taglib/taglib-mswin32/include/taglib/tstringlist.h",
     "ext/taglib/taglib-mswin32/include/taglib/uniquefileidentifierframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/unknownframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/unsynchronizedlyricsframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/urllinkframe.h",
     "ext/taglib/taglib-mswin32/include/taglib/vorbisfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/vorbisproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/wavpackfile.h",
     "ext/taglib/taglib-mswin32/include/taglib/wavpackproperties.h",
     "ext/taglib/taglib-mswin32/include/taglib/xingheader.h",
     "ext/taglib/taglib-mswin32/include/taglib/xiphcomment.h",
     "ext/taglib/taglib-mswin32/lib/pkgconfig/taglib_c.pc",
     "ext/taglib/taglib-mswin32/lib/tag.lib",
     "ext/taglib/taglib-mswin32/lib/tag_c.lib",
     "ext/taglib/taglib_i386-mingw32.source",
     "ext/taglib/taglib_i386-mswin32.source",
     "ext/taglib/taglib_x86_64-linux.source",
     "lib/TagLib.rb",
     "lib/TagLib_doc.rb",
     "lib/rtaglib_mswin32.rb",
     "lib/tagfile.rb",
     "swig/Doxyfile",
     "swig/Rakefile",
     "swig/TagLib_doc.rb",
     "swig/make_doc.rb",
     "swig/process_cxx.rb",
     "swig/rake_ext_conf.rb",
     "swig/taglib.i",
     "swig/test.rb",
     "test/test_read.rb",
     "test/test_taglib.rb",
     "test/test_write.rb"
  ]
  s.homepage = %q{http://github.com/masterkain/rtaglib}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Tagging Library}
  s.test_files = [
    "test/test_read.rb",
     "test/test_taglib.rb",
     "test/test_write.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

