#!/usr/bin/env ruby
require 'ftools'
$:.unshift(File.dirname(__FILE__)+"/../lib")
$:.unshift(File.dirname(__FILE__)+"/../ext")
require 'tagfile'
require 'test/unit'
require 'tmpdir'

class RTagFileWriteTestCase < Test::Unit::TestCase
	def setup
		@original=File.dirname(__FILE__)+"/../data/440Hz-5sec.mp3"
        @temp_dir=Dir::tmpdir+"/rtaglib"
        FileUtils.mkdir(@temp_dir) if !File.exists? @temp_dir
        FileUtils.chmod(0777, @temp_dir)
        
		@copy=@temp_dir+"/test_"+sprintf("%06d",rand(10000))+".mp3"
		File.copy(@original, @copy)
        FileUtils.chmod(0777, @copy)

		@file=::TagFile::File.new(@copy)
	end
	def teardown
		File.delete(@copy)
	end
	def test_title()
		@file.title="Saw2"
		@file.save
		assert_equal("Saw2",@file.title)
	end
	def test_artist()
		@file.artist="Nobody"
		@file.save
		assert_equal("Nobody",@file.artist)
	end
	def test_album()
		@file.album="Dupa"
		@file.save
		assert_equal("Dupa",@file.album)
	end
	def test_genre()
		@file.genre="Progressive Rock"
		@file.save
		assert_equal("Progressive Rock",@file.genre)
	end
	def test_track()
		@file.track=2
		@file.save
		assert_equal(2,@file.track)
	end
	def test_year()
		@file.year=2010
		@file.save
		assert_equal(2010,@file.year)
	end
	def test_comment()
		@file.comment="New Comment"
		@file.save
		assert_equal("New Comment",@file.comment)
	end

	def test_duck_typing_integer_values
		assert_raise(TypeError) do
			@file.year = "2008" # note: we set a String here!
		end
		# now, give the String the integer casting function
		::String.module_eval do
			# let's the string behave like an int: just call to_i to get an integer value
			alias :to_int :to_i
		end
		assert_nothing_raised do
			@file.year = "2008" # note: we set a String here!
		end
    # clean up: remove the added method
    String.send :remove_method, :to_int
		assert_equal(2008,@file.year) # note: the result is a Fixnum
	end # def test_duck_typing_integer_values

	def test_duck_typing_string_values
		assert_raise(TypeError) do
			@file.title = Math::PI # note: we set a Float here!
		end
		# now, give the String the integer casting function
		::Float.module_eval do
			# let's the float behave like a string: round to five digits
			def to_str
				sprintf("%0.5f", self)
			end
		end
		assert_nothing_raised do
			@file.title = Math::PI # note: we set a Float here!
		end
    # clean up: remove the added method
    Float.send :remove_method, :to_str
		assert_equal("3.14159",@file.title) # note: the result is a String
	end # def test_duck_typing_string_values
end

# arch-tag: test
