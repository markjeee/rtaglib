#!/usr/bin/ruby
$:.unshift(File.dirname(__FILE__)+"/../lib")
require 'TagLib'
require 'tmpdir'
require 'fileutils'
require 'test/unit'
class RtaglibReadTestCase < Test::Unit::TestCase
	def setup
        @data_dir=File.dirname(__FILE__)+"/../data/"
        @temp_dir=Dir::tmpdir+"/rtaglib"
        FileUtils.mkdir(@temp_dir) if !File.exists? @temp_dir
        FileUtils.chmod(0777, @temp_dir)
    end
    def teardown
	begin
        Dir.glob(@temp_dir+"/*").each{|f|
           FileUtils.rm(f)
        }
	rescue Exception
	end
    end
    def get_copy(original)
        original=~/.*\.(.+)/
        ext=$1
        copy=@temp_dir+"/test_"+sprintf("%06d",rand(10000))+"."+ext
	
	FileUtils.copy(original, copy)
        FileUtils.chmod(0777, copy)
	copy
    end
    # TagLib::File test for
    # - writable?
    # - open?
    # - valid?
    # - seek (with 1 and 2 arguments)
    # - readBlock
    # - find (with 1 and 2 arguments)
    # - lenght
    def test_file
        mp3=@data_dir+"440Hz-5sec.mp3"
        copy=get_copy(mp3)
        file=TagLib::MPEG::File.new(copy)
        assert(file.writable?)
        assert(file.open?)
        assert(file.valid?)
        file.seek(0);
        expected=sprintf("%c%c%c%c%c%c%c%c%c%c",0x49,0x44,0x33,0x04,0x00,0x80, 0x00,0x00,0x07,0x76)
        assert_equal(expected,file.readBlock(10))
        expected=sprintf("%c%c%c%c%c%c%c%c%c%c",0x54,0x49,0x54,0x32,0x00,0x00, 0x00,0x10,0x00,0x00)
        assert_equal(expected,file.readBlock(10))

        file.seek(-6, TagLib::File::End)
        expected=sprintf("%c%c%c%c%c%c",0x77,0x61,0x72,0x00,0x01,0x47)
        assert_equal(expected,file.readBlock(6))
        
        needle=sprintf("%c%c%c%c%c",0x20,0xF1,0x8A,0xE6,0x63)
        assert_equal(0x40D,file.find1(needle))
        needle=sprintf("%c%c%c%c%c",0x22,0x22,0x22,0xE6,0x63)
        assert_equal(-1,file.find2(needle,0))
        assert_equal(0x7B46,file.length())
        expected=sprintf("%c%c%c%c%c%c",0x01,0x02,0x03,0x04,0x05,0x06)
        file.seek(0)
        file.writeBlock(expected)
        file.save
        file=nil
        file=TagLib::MPEG::File.new(copy)
        file.seek(0)
        #assert_equal(expected,file.readBlock(6))
    end
    # TagLib::FileRef test for
    # - ::defaultFileExtensions()
    # - length
    # - save
    # - tag: getters and setters for title, artist, album, year, track, genre, comment
    # - audioproperties: bitrate,channels,sampleRate and channels
    # - isNull (null?)
    def test_fileref
        assert_equal(%w{ogg flac oga mp3 mpc wv spx tta}, TagLib::FileRef.defaultFileExtensions())
        bitrate={'flac'=>168,'wv'=>235,'mp3'=>48,'mpc'=>41,'ogg'=>80}
        channels={'flac'=>1,'wv'=>1,'mp3'=>1,'mpc'=>2,'ogg'=>1}

        Dir.glob(@data_dir+"/440*").each{|f|
            fr=TagLib::FileRef.new(f)
            f=~/.+\.(.+)/
            ext=$1
            
            assert_equal(5,fr.audioProperties.length, "Error on file #{f}")
            assert_equal(bitrate[ext],fr.audioProperties.bitrate, "Error on file #{f}")
            assert_equal(44100,fr.audioProperties.sampleRate, "Error on file #{f}")
            assert_equal(channels[ext],fr.audioProperties.channels, "Error on file #{f}")

            assert_equal("440Hz Sine Wave",fr.tag().title,"Error on file #{f}")
            assert_equal("Dr. Lex",fr.tag().artist,"Error on file #{f}")
            assert_equal("http://www.dr-lex.be/",fr.tag().album,"Error on file #{f}")
            assert_equal(2008,fr.tag().year,"Error on file #{f}")
            assert_equal(1,fr.tag().track,"Error on file #{f}")
            assert_equal("Lo-Fi",fr.tag().genre, "Error on file #{f}")
            assert_equal("http://www.dr-lex.be/software/testsounds.html", fr.tag().comment,"Error on file #{f}")
            assert(!fr.null?)
        }
        mp3=@data_dir+"440Hz-5sec.mp3"
        copy=get_copy(mp3)
        fr2=TagLib::FileRef.new(copy)
        fr2.tag().title=TagLib::String.new("new title");
        fr2.tag().artist=TagLib::String.new("new artist");
        fr2.tag().album=TagLib::String.new("new album");
        fr2.tag().year=2000;
        fr2.tag().track=10;
        fr2.tag().genre=TagLib::String.new("Rock");
        fr2.tag().comment=TagLib::String.new("new comment");
        
        fr2.save()
        copy2=get_copy(copy)
        fr2.tag().title=TagLib::String.new("sfsd")
        fr2.save()
        fr3=TagLib::FileRef.new(copy2)
        assert_equal("new title",fr3.tag.title)
        assert_equal("new artist",fr3.tag.artist)
        assert_equal("new album",fr3.tag.album)
        assert_equal(2000,fr3.tag.year)
        assert_equal(10,fr3.tag.track)
        assert_equal("Rock",fr3.tag.genre)
        assert_equal("new comment",fr3.tag.comment)
        
    end
    # Bug 2009-05-15
    # Reporter: Jason Newton
    # Assign UTF8 strings to tags return garbage
    def test_bug_2009_05_15
        mp3=@data_dir+"440Hz-5sec.mp3"
        copy=get_copy(mp3)
        copy2=get_copy(mp3)
        fr=TagLib::FileRef.new(copy)
        utf8_string="大塚愛"
        expected="\345\244\247\345\241\232\346\204\233"
        fr.tag().title=TagLib::String.new(utf8_string)
        fr.save
        fr=nil
        fr=TagLib::FileRef.new(copy)
        assert_equal(expected,fr.tag.title)

        mp3=@data_dir+"test_jason.mp3"
        s=get_copy(mp3)
        d=get_copy(mp3)
        s_tag=TagLib::FileRef.new(s)
        d_tag=TagLib::MPEG::File.new(d)
        artist="大塚愛"
#        puts "artist = #{artist} => #{artist.inspect}"
        assert_equal(artist,s_tag.tag.artist)
        assert_equal(artist,d_tag.ID3v2Tag.artist)
        d_tag.ID3v2Tag.artist=TagLib::String.new(s_tag.tag.artist)        
        assert_equal(d_tag.ID3v2Tag.artist, s_tag.tag.artist)
        d_tag.save
        d_tag=nil
        d_tag=TagLib::FileRef.new(d)
        assert_equal(artist, d_tag.tag.artist)
        assert_equal(d_tag.tag.artist, s_tag.tag.artist)
=begin
        if(`which id3info`)
            `id3info #{s}` =~ /^=== TPE1.+: (.+)$/
            vc_out=$1
            assert_equal(artist,vc_out,"id3info output (#{vc_out}) not equal to #{artist}")
        end
=end

        ogg=@data_dir+"test_jason.ogg"
        s=get_copy(ogg)
        d=get_copy(ogg)
        s_tag=TagLib::FileRef.new(s)
        d_tag=TagLib::FileRef.new(d)
        artist="大塚愛"
        assert_equal(artist,s_tag.tag.artist)
        assert_equal(artist,d_tag.tag.artist)
        d_tag.tag.artist=TagLib::String.new(s_tag.tag.artist,TagLib::String::UTF8)        
        assert_equal(d_tag.tag.artist, s_tag.tag.artist)
        d_tag.save
        d_tag=TagLib::FileRef.new(d)
        assert_equal(d_tag.tag.artist, s_tag.tag.artist)
	if PLATFORM=~/mswin/
		else
        if(`which vorbiscomment`)
            `vorbiscomment #{d}` =~ /^ARTIST=(.+)$/
            vc_out=$1
            assert_equal(artist,vc_out,"vorbiscomment output (#{vc_out}) not equal to #{artist}")
	end
	end
 
    end
    def test_flac
        original=@data_dir+"440Hz-5sec.flac"
        copy_xiph=get_copy(original)
        copy_id1=get_copy(original)
        copy_id2=get_copy(original)        
        flac_xiph=TagLib::FLAC::File.new(copy_xiph,true)
        flac_id1=TagLib::FLAC::File.new(copy_id1,true)
        flac_id2=TagLib::FLAC::File.new(copy_id2,true)
        
        # file
        assert_equal(34,flac_xiph.streamInfoData.length)
        assert_equal(105299, flac_xiph.streamLength)
        # audioproperties
        ap=flac_xiph.audioProperties
        assert_equal(5,ap.length)
        assert_equal(168,ap.bitrate)
        assert_equal(44100,ap.sampleRate)
        assert_equal(1,ap.channels)
        assert_equal(16,ap.sampleWidth)
        # comments
        xiph=flac_xiph.xiphComment()
        xiph.setTitle(TagLib::String.new("xiph"))
        flac_xiph.save()
        assert_equal("xiph",flac_xiph.tag().title)
        assert_nil(flac_xiph.ID3v1Tag())
        assert_nil(flac_xiph.ID3v2Tag())
        
        id1=flac_id1.ID3v1Tag(true)
        
        id1.setTitle(TagLib::String.new("id1"))
        flac_id1.save()
        assert_equal("id1",id1.title)
        
        assert_not_nil(flac_id1.xiphComment())
        assert_nil(flac_id1.ID3v2Tag())
        
        
         id2=flac_id2.ID3v2Tag(true)
         id2.setTitle(TagLib::String.new("id2"))
         flac_id2.save()
         assert_equal("id2",id2.title)

        assert_not_nil(flac_id2.xiphComment())
        assert_nil(flac_id2.ID3v1Tag())
    end
    # 
    def test_mpeg
        original=@data_dir+"440Hz-5sec.mp3"
        copy=get_copy(original)
        mp3=TagLib::MPEG::File.new(copy)
        %w{tag ID3v1Tag ID3v2Tag}.each {|f|
            assert_equal("440Hz Sine Wave",mp3.send(f).title)
        }
        # file
        # strip only id3v1
        mp3.strip(TagLib::MPEG::File::ID3v1)
        assert_nil(mp3.ID3v1Tag)
        assert_not_nil(mp3.ID3v2Tag)
        copy=get_copy(original)
        mp3=TagLib::MPEG::File.new(copy)
        # strip all
        mp3.strip()
        assert_nil(mp3.ID3v1Tag)
        assert_nil(mp3.ID3v2Tag)
        
        # properties
        
        assert_equal(0,mp3.audioProperties.version)
        assert_equal(3,mp3.audioProperties.layer)
        assert(!mp3.audioProperties.protectionEnabled)
        assert_equal(TagLib::MPEG::Header::SingleChannel, mp3.audioProperties.channelMode)
        assert(!mp3.audioProperties.isCopyrighted)
        assert(mp3.audioProperties.isOriginal)
        
        
        
    end
    # Note: strip doesn't work on APE tags on TagLib
    def test_mpc
        original=@data_dir+"440Hz-5sec.mpc"
        copy=get_copy(original)
        fr=TagLib::FileRef.new(copy)
        fr.tag.title=TagLib::String.new("440Hz Sine Wave")
        fr.save
        mpc=TagLib::MPC::File.new(copy)
        %w{tag APETag}.each {|f|
            assert_equal("440Hz Sine Wave",mpc.send(f).title, "#{f} tag")
        }
        mpc=TagLib::MPC::File.new(copy)
        mpc.ID3v1Tag(true).title=TagLib::String.new("440Hz Sine Wave - id3")
        mpc.save
        mpc=nil
        mpc=TagLib::MPC::File.new(copy)
        assert_equal("440Hz Sine Wave - id3",mpc.ID3v1Tag(false).title)

        mpc=nil
        # file
        # strip only id3v1
        mpc=TagLib::MPC::File.new(copy)        
        mpc.strip(TagLib::MPC::File::ID3v1)
        mpc.save
        mpc1=TagLib::MPC::File.new(copy)
        
        assert_nil(mpc1.ID3v1Tag)
        assert_not_nil(mpc1.APETag)
        copy=get_copy(original)
        mpc=TagLib::MPC::File.new(copy)
        # strip all
        mpc.strip()
        mpc.save
        mpc1=TagLib::MPC::File.new(copy)

        assert_nil(mpc1.ID3v1Tag)
        # Bug on TagLib
        #       assert_nil(mpc1.APETag)
        
        # properties
        
        assert_equal(7,mpc.audioProperties.mpcVersion)
    end
    
    
    
    def test_fieldmap
        fl=TagLib::FieldListMap.new()
        fl.insert(TagLib::String.new("key"),["val1","val2"])
        assert_equal(["val1","val2"],fl[TagLib::String.new("key")])
        assert_nil(fl[TagLib::String.new("2")])
        fl.insert(TagLib::String.new("key2"),["val3","val4"])
        assert_equal({'key'=>["val1","val2"],"key2"=>["val3","val4"]}, fl.hash)
        assert_equal(fl.size,fl.length)
    end
    def test_xiph_comment
         original=@data_dir+"440Hz-5sec.flac"
         copy_xiph=get_copy(original)
         flac_xiph=TagLib::FLAC::File.new(copy_xiph,true)
         xc=flac_xiph.xiphComment
         fl=xc.fieldListMap
         fl.hash.each {|k,v|
             xc.removeField(TagLib::String.new(k))
         }
         assert(xc.empty?)
         xc.setTitle(TagLib::String.new("T"))
         xc.setArtist(TagLib::String.new("A"))
         xc.addField(TagLib::String.new("c"),TagLib::String.new("C1"),false)
         xc.addField(TagLib::String.new("c"),TagLib::String.new("C2"),false)
         expected={"TITLE"=>["T"],"ARTIST"=>["A"],"C"=>["C1","C2"]}
         assert_equal(expected,fl.hash)
     end
end
