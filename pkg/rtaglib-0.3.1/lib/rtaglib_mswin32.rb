if RUBY_PLATFORM =~ /mswin32/ || RUBY_PLATFORM =~ /mingw32/
  TAGLIB_BASE_PATH = File.expand_path(File.dirname(__FILE__)+"/..")+"/ext/taglib/taglib-mswin32"
  ENV['PATH'] += ";" + (TAGLIB_BASE_PATH + "/bin").gsub("/","\\")
end