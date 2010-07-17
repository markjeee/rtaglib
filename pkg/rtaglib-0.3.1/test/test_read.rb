#!/usr/bin/env ruby
$:.unshift(File.dirname(__FILE__)+"/../lib")
$:.unshift(File.dirname(__FILE__)+"/../ext")
require 'tagfile'
require 'test/unit'
class RTagFileReadTestCase < Test::Unit::TestCase
	def setup

	    @file=::TagFile::File.new(File.dirname(__FILE__)+"/../data/440Hz-5sec.mp3")
	end
	def test_title()
		assert_equal("440Hz Sine Wave",@file.title)
	end
	def test_artist()
		assert_equal("Dr. Lex",@file.artist)
	end
	def test_album()
		assert_equal("http://www.dr-lex.be/",@file.album)
	end
	def test_genre()
		assert_equal("Lo-Fi",@file.genre)
	end
	def test_track()
		assert_equal(1,@file.track)
	end
	def test_year()
		assert_equal(2008,@file.year)
	end
	def test_comment()
		assert_equal("http://www.dr-lex.be/software/testsounds.html",@file.comment)
	end
	def test_length()
		assert_equal(5, @file.length)
	end
	def test_bitrate()
		assert_equal(48, @file.bitrate)
	end
	def test_samplerate()
		assert_equal(44100,@file.samplerate)
	end
	def test_channels()
		assert_equal(1,@file.channels)
	end
end

# arch-tag: test
