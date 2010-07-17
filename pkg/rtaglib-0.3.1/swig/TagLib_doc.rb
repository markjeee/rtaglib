 # <b>
 # A namespace for all TagLib related classes and functions.     .</b>
 # 
 # 
 # This namespace contains everything in TagLib. For projects working with TagLib extensively it may be conveniten to add a usingnamespaceTagLib;
 #      
 # 
  module TagLib
      class TagLib::FrameList
      def size()
      end
      def contains()
      end
      def isEmpty()
      end
    end
 # <b>
 # A byte vector.     .</b>
 # 
 # 
 # This class provides a byte vector with some methods that are useful for tagging purposes. Many of the search functions are tailored to what is useful for finding tag related paterns in a data array.     
 # 
    class TagLib::ByteVector
 # 
 # Returns a pointer to the internal data structure which may not be modified.         
 # 
      def data()
      end
 # 
 # Returns the size of the array.         
 # 
      def size()
      end
    end
    class TagLib::GenreMap
      def clear()
      end
      def size()
      end
      def empty?()
      end
      def contains()
      end
      def isEmpty()
      end
      def insert()
      end
      def length()
      end
      def []()
      end
    end
 # <b>
 # A wide string class suitable for unicode.     .</b>
 # 
 # 
 # This is an implicitly shared wide string. For storage it uses TagLib::wstring, but as this is an implementation detail this of course could change. Strings are stored internally as UTF-16BE. (Without the BOM (Byte Order Mark)The use of implicit sharing means that copying a string is cheap, the only cost comes into play when the copy is modified. Prior to that the string just has a pointer to the data of the parent String. This also makes this class suitable as a function return type.In addition to adding implicit sharing, this class keeps track of four possible encodings, which are the four supported by the ID3v2 standard.     
 # 
    class TagLib::String
 # 
 # Creates and returns a C-String based on the data. This string is still owned by the String (class) and as such should not be deleted by the user.If unicode if false (the default) this string will be encoded in Latin1. If it is true the returned C-String will be UTF-8 encoded.This string remains valid until the String instance is destroyed or another export method is called.This however has the side effect that this C-String will remain in memory in addition to other memory that is consumed by the String instance. So, this method should not be used on large strings or where memory is critical. 
 #         
 # 
      def toCString(unicode = false)
      end
    end
 # <b>
 # A list of ByteVectors.     .</b>
 # 
 # 
 # A List specialization with some handy features useful for ByteVectors.     
 # 
    class TagLib::ByteVectorList
      def size()
      end
      def contains()
      end
      def isEmpty()
      end
    end
    class TagLib::ItemListMap
      def clear()
      end
      def size()
      end
      def empty?()
      end
      def contains()
      end
      def isEmpty()
      end
      def insert()
      end
      def length()
      end
    end
 # <b>
 # A simple, abstract interface to common audio properties.     .</b>
 # 
 # 
 # The values here are common to most audio formats. For more specific, codec dependant values, please see see the subclasses APIs. This is meant to compliment the TagLib::File and TagLib::Tag APIs in providing a simple interface that is sufficient for most applications.     
 # 
    class TagLib::AudioProperties
 # 
 # Returns the sample rate in Hz.         
 # 
      def sampleRate()
      end
 # 
 # Returns the number of audio channels.         
 # 
      def channels()
      end
 # 
 # Returns the length of the file in seconds.         
 # 
      def length()
      end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
      def bitrate()
      end
    end
 # <b>
 # A list of strings.     .</b>
 # 
 # 
 # This is a spcialization of the List class with some members convention for string operations.     
 # 
    class TagLib::StringList
      def size()
      end
      def contains()
      end
      def isEmpty()
      end
    end
    class TagLib::FieldListMap
      def clear()
      end
      def size()
      end
      def empty?()
      end
      def contains()
      end
      def isEmpty()
      end
      def insert()
      end
      def length()
      end
      def []()
      end
    end
 # <b>
 # This class provides a simple abstraction for creating and handling files.     .</b>
 # 
 # 
 # FileRef exists to provide a minimal, generic and value-based wrapper around a File. It is lightweight and implicitly shared, and as such suitable for pass-by-value use. This hides some of the uglier details of TagLib::File and the non-generic portions of the concrete file implementations.This class is useful in a &quot;simple usage&quot; situation where it is desirable to be able to get and set some of the tag information that is similar across file types.Also note that it is probably a good idea to plug this into your mime type system rather than using the constructor that accepts a file name using the FileTypeResolver.FileTypeResolver addFileTypeResolver() 
 #     
 # 
    class TagLib::FileRef
      # Singleton methods
      def self.defaultFileExtensions()
      end
 # 
 # Returns true if the file (and as such other pointers) are null.         
 # 
      def isNull()
      end
 # 
 # Returns a pointer to represented file&apos;s tag.This pointer will become invalid when this FileRef and all copies pass out of scope.
 # File::tag() 
 #         
 # 
      def tag()
      end
      def null?()
      end
 # 
 # Returns the audio properties for this FileRef. If no audio properties were read then this will returns a null pointer.         
 # 
      def audioProperties()
      end
 # 
 # Returns a pointer to the file represented by this handler class.As a general rule this call should be avoided since if you need to work with file objects directly, you are probably better served instantiating the File subclasses (i.e. MPEG::File) manually and working with their APIs.This handle exists to provide a minimal, generic and value-based wrapper around a File. Accessing the file directly generally indicates a moving away from this simplicity (and into things beyond the scope of FileRef).This pointer will become invalid when this FileRef and all copies pass out of scope. 
 #         
 # 
      def file()
      end
 # 
 # Saves the file. Returns true on success.         
 # 
      def save()
      end
    end
    class TagLib::FrameListMap
      def clear()
      end
      def size()
      end
      def empty?()
      end
      def contains()
      end
      def isEmpty()
      end
      def insert()
      end
      def length()
      end
      def []()
      end
    end
 # <b>
 # A simple, generic interface to common audio meta data fields.     .</b>
 # 
 # 
 # This is an attempt to abstract away the difference in the meta data formats of various audio codecs and tagging schemes. As such it is generally a subset of what is available in the specific formats but should be suitable for most applications. This is meant to compliment the generic APIs found in TagLib::AudioProperties, TagLib::File and TagLib::FileRef.     
 # 
    class TagLib::Tag
      def track=()
      end
 # 
 # Sets the genre to s. If s is String::null then this value will be cleared. For tag formats that use a fixed set of genres, the appropriate value will be selected based on a string comparison. A list of available genres for those formats should be available in that type&apos;s implementation.         
 # 
      def setGenre(s)
      end
 # 
 # Returns the track name; if no track name is present in the tag String::null will be returned.         
 # 
      def title()
      end
      def title=()
      end
 # 
 # Sets the title to s. If s is String::null then this value will be cleared.         
 # 
      def setTitle(s)
      end
 # 
 # Returns the year; if there is no year set, this will return 0.         
 # 
      def year()
      end
 # 
 # Sets the year to i. If s is 0 then this value will be cleared.         
 # 
      def setYear(i)
      end
 # 
 # Returns the artist name; if no artist name is present in the tag String::null will be returned.         
 # 
      def artist()
      end
      def year=()
      end
      def artist=()
      end
 # 
 # Sets the artist to s. If s is String::null then this value will be cleared.         
 # 
      def setArtist(s)
      end
 # 
 # Returns the track comment; if no comment is present in the tag String::null will be returned.         
 # 
      def comment()
      end
 # 
 # Sets the track to i. If s is 0 then this value will be cleared.         
 # 
      def setTrack(i)
      end
      def comment=()
      end
      def empty?()
      end
 # 
 # Returns the album name; if no album name is present in the tag String::null will be returned.         
 # 
      def album()
      end
      def album=()
      end
 # 
 # Sets the album to s. If s is String::null then this value will be cleared.         
 # 
      def setAlbum(s)
      end
 # 
 # Returns true if the tag does not contain any data. This should be reimplemented in subclasses that provide more than the basic tagging abilities in this class.         
 # 
      def isEmpty()
      end
 # 
 # Returns the genre name; if no genre is present in the tag String::null will be returned.         
 # 
      def genre()
      end
      def genre=()
      end
 # 
 # Sets the comment to s. If s is String::null then this value will be cleared.         
 # 
      def setComment(s)
      end
 # 
 # Returns the track number; if there is no track number set, this will return 0.         
 # 
      def track()
      end
    end
 # <b>
 # A file class with some useful methods for tag manipulation.     .</b>
 # 
 # 
 # This class is a basic file class with some methods that are particularly useful for tag editors. It has methods to take advantage of ByteVector and a binary search method for finding patterns in a file.     
 # 
    class TagLib::File
      def isWritable()
      end
 # 
 # Returns the file name in the local file system encoding.         
 # 
      def name()
      end
 # 
 # Move the I/O pointer to offset in the file from position p. This defaults to seeking from the beginning of the file.Position 
 #         
 # 
      def seek(offset,p = Beginning)
      end
      def find3()
      end
      def read_only?()
      end
 # 
 # Since the file can currently only be opened as an argument to the constructor (sort-of by design), this returns if that open succeeded.         
 # 
      def isOpen()
      end
 # 
 # Reads a block of size length at the current get pointer.         
 # 
      def readBlock(length)
      end
 # 
 # Returns the offset in the file that pattern occurs at or -1 if it can not be found. If before is set, the search will only continue until the pattern before is found. This is useful for tagging purposes to search for a tag before the synch frame.Searching starts at fromOffset and proceeds from the that point to the beginning of the file and defaults to the end of the file.This has the practial limitation that pattern can not be longer than the buffer size used by readBlock(). Currently this is 1024 bytes. 
 #         
 # 
      def rfind(pattern,fromOffset = 0,before = ByteVector::null)
      end
 # 
 # Reset the end-of-file and error flags on the file.         
 # 
      def clear()
      end
 # 
 # Returns a pointer to this file&apos;s tag. This should be reimplemented in the concrete subclasses.         
 # 
      def tag()
      end
 # 
 # Attempts to write the block data at the current get pointer. If the file is currently only opened read only -- i.e. readOnly() returns true -- this attempts to reopen the file in read/write mode.This should be used instead of using the streaming output operator for a ByteVector. And even this function is significantly slower than doing output with a char[]. 
 #         
 # 
      def writeBlock(data)
      end
 # 
 # Removes a block of the file starting a start and continuing for length bytes.This method is slow since it involves rewriting all of the file after the removed portion. 
 #         
 # 
      def removeBlock(start = 0,length = 0)
      end
      def writable?()
      end
      def open?()
      end
 # 
 # Returns true if the file is open and readble and valid information for the Tag and / or AudioProperties was found.         
 # 
      def isValid()
      end
      def find1()
      end
 # 
 # Insert data at position start in the file overwriting replace bytes of the original content.This method is slow since it requires rewriting all of the file after the insertion point. 
 #         
 # 
      def insert(data,start = 0,replace = 0)
      end
 # 
 # Returns true if the file is read only (or if the file can not be opened).         
 # 
      def readOnly()
      end
 # 
 # Returns a pointer to this file&apos;s audio properties. This should be reimplemented in the concrete subclasses. If no audio properties were read then this will return a null pointer.         
 # 
      def audioProperties()
      end
 # 
 # Returns the current offset withing the file.         
 # 
      def tell()
      end
      def find2()
      end
 # 
 # Returns the length of the file.         
 # 
      def length()
      end
      def valid?()
      end
 # 
 # Save the file and its associated tags. This should be reimplemented in the concrete subclasses. Returns true if the save succeeds.On UNIX multiple processes are able to write to the same file at the same time. This can result in serious file corruption. If you are developing a program that makes use of TagLib from multiple processes you must insure that you are only doing writes to a particular file from one of them. 
 #         
 # 
      def save()
      end
    end
 # <b>
 # An implementation of TrueAudio metadata.     .</b>
 # 
 # 
 # This is implementation of TrueAudio metadata.This supports ID3v1 and ID3v2 tags as well as reading stream properties from the file.     
 # 
      module TagLib::TrueAudio
       # <b>
 # An implementation of audio property reading for TrueAudio.     .</b>
 # 
 # 
 # This reads the data from an TrueAudio stream found in the AudioProperties API.     
 # 
        class TagLib::TrueAudio::Properties < TagLib::AudioProperties
 # 
 # Returns the major version number.         
 # 
          def ttaVersion()
          end
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns number of bits per sample.         
 # 
          def bitsPerSample()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
        end
 # <b>
 # An implementation of TagLib::File with TrueAudio specific methods.     .</b>
 # 
 # 
 # This implements and provides an interface for TrueAudio files to the TagLib::Tag and TagLib::AudioProperties interfaces by way of implementing the abstract TagLib::File API as well as providing some additional information specific to TrueAudio files.     
 # 
        class TagLib::TrueAudio::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def read_only?()
          end
          def isOpen()
          end
 # 
 # Returns a pointer to the ID3v2 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v2 tag. If create is true it will create an ID3v1 tag if one does not exist. If there is already an APE tag, the new ID3v1 tag will be placed after it.The Tag is still owned by the TrueAudio::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v1Tag(create = false)
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the Tag for this file.         
 # 
          def tag()
          end
          def writeBlock()
          end
 # 
 # Set the ID3v2::FrameFactory to something other than the default.ID3v2FrameFactory 
 #         
 # 
          def setID3v2FrameFactory(factory)
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
 # 
 # This will remove the tags that match the OR-ed together TagTypes from the file. By default it removes all tags.This will also invalidate pointers to the tags as their memory will be freed. In order to make the removal permanent save() still needs to be called 
 #         
 # 
          def strip(tags = AllTags)
          end
          def isValid()
          end
          def find1()
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the TrueAudio::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
          def length()
          end
 # 
 # Returns a pointer to the ID3v1 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v1 tag. If create is true it will create an ID3v1 tag if one does not exist. If there is already an APE tag, the new ID3v1 tag will be placed after it.The Tag is still owned by the TrueAudio::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v2Tag(create = false)
          end
          def valid?()
          end
 # 
 # Saves the file.         
 # 
          def save()
          end
        end
      end
 # <b>
 # A namespace for the classes used by Ogg-based metadata files.     .</b>
 # 
 # 
 #     
 # 
      module TagLib::Ogg
       # <b>
 # An implementation of Ogg pages.     .</b>
 # 
 # 
 # This is an implementation of the pages that make up an Ogg stream. This handles parsing pages and breaking them down into packets and handles the details of packets spanning multiple pages and pages that contiain multiple packets.In most Xiph.org formats the comments are found in the first few packets, this however is a reasonably complete implementation of Ogg pages that could potentially be useful for non-meta data purposes.     
 # 
        class TagLib::Ogg::Page
 # 
 # Returns the number of packets (whole or partial) in this page.         
 # 
          def packetCount()
          end
 # 
 # Returns a pointer to the header for this page. This pointer will become invalid when the page is deleted.         
 # 
          def header()
          end
 # 
 # Returns a list of the packets in this page.Either or both the first and last packets may be only partial. 
 # PageHeader::firstPacketContinued() 
 #         
 # 
          def packets()
          end
 # 
 # Returns the index of the first packet wholly or partially contained in this page.setFirstPacketIndex() 
 #         
 # 
          def firstPacketIndex()
          end
 # 
 # Returns the size of the page in bytes.         
 # 
          def size()
          end
 # 
 # Sets the index of the first packet in the page.firstPacketIndex() 
 #         
 # 
          def setFirstPacketIndex(index)
          end
 # 
 #         
 # 
          def render()
          end
 # 
 # Checks to see if the specified packet is contained in the current page.ContainsPacketFlags 
 #         
 # 
          def containsPacket(index)
          end
 # 
 # Returns the page&apos;s position within the file (in bytes).         
 # 
          def fileOffset()
          end
        end
 # <b>
 # Ogg Vorbis comment implementation.     .</b>
 # 
 # 
 # This class is an implementation of the Ogg Vorbis comment specification, to be found in section 5 of the Ogg Vorbis specification. Because this format is also used in other (currently unsupported) Xiph.org formats, it has been made part of a generic implementation rather than being limited to strictly Vorbis.Vorbis comments are a simple vector of keys and values, called fields. Multiple values for a given key are supported.fieldListMap() 
 #     
 # 
        class TagLib::Ogg::XiphComment < TagLib::Tag
          def track=()
          end
 # 
 # Sets the genre to s. If s is String::null then this value will be cleared. For tag formats that use a fixed set of genres, the appropriate value will be selected based on a string comparison. A list of available genres for those formats should be available in that type&apos;s implementation.         
 # 
          def setGenre(s)
          end
 # 
 # Returns the track name; if no track name is present in the tag String::null will be returned.         
 # 
          def title()
          end
 # 
 # Add the field specified by key with the data value. If replace is true, then all of the other fields with the same key will be removed first.If the field value is empty, the field will be removed.         
 # 
          def addField(key,value,replace = true)
          end
          def title=()
          end
 # 
 # Sets the title to s. If s is String::null then this value will be cleared.         
 # 
          def setTitle(s)
          end
 # 
 # Returns the year; if there is no year set, this will return 0.         
 # 
          def year()
          end
 # 
 # Sets the year to i. If s is 0 then this value will be cleared.         
 # 
          def setYear(i)
          end
 # 
 # Returns the artist name; if no artist name is present in the tag String::null will be returned.         
 # 
          def artist()
          end
          def year=()
          end
          def artist=()
          end
 # 
 # Sets the artist to s. If s is String::null then this value will be cleared.         
 # 
          def setArtist(s)
          end
 # 
 # Returns the track comment; if no comment is present in the tag String::null will be returned.         
 # 
          def comment()
          end
 # 
 # Remove the field specified by key with the data value. If value is null, all of the fields with the given key will be removed.         
 # 
          def removeField(key,value = String::null)
          end
 # 
 # Sets the track to i. If s is 0 then this value will be cleared.         
 # 
          def setTrack(i)
          end
          def comment=()
          end
          def empty?()
          end
 # 
 # Returns the album name; if no album name is present in the tag String::null will be returned.         
 # 
          def album()
          end
 # 
 # Returns the number of fields present in the comment.         
 # 
          def fieldCount()
          end
 # 
 # Renders the comment to a ByteVector suitable for inserting into a file.If addFramingBit is true the standard Vorbis comment framing bit will be appended. However some formats (notably FLAC) do not work with this in place.         
 # 
          def render(addFramingBit)
          end
          def album=()
          end
 # 
 # Sets the album to s. If s is String::null then this value will be cleared.         
 # 
          def setAlbum(s)
          end
 # 
 # Returns true if the field is contained within the comment.This is safer than checking for membership in the FieldListMap. 
 #         
 # 
          def contains(key)
          end
 # 
 # Returns true if the tag does not contain any data. This should be reimplemented in subclasses that provide more than the basic tagging abilities in this class.         
 # 
          def isEmpty()
          end
 # 
 # Returns a reference to the map of field lists. Because Xiph comments support multiple fields with the same key, a pure Map would not work. As such this is a Map of string lists, keyed on the comment field name.The standard set of Xiph/Vorbis fields (which may or may not be contained in any specific comment) is:
 # 
 # TITLE 
 # 
 # VERSION 
 # 
 # ALBUM 
 # 
 # ARTIST 
 # 
 # PERFORMER 
 # 
 # COPYRIGHT 
 # 
 # ORGANIZATION 
 # 
 # DESCRIPTION 
 # 
 # GENRE 
 # 
 # DATE 
 # 
 # LOCATION 
 # 
 # CONTACT 
 # 
 # ISRC 
 # 
 # For a more detailed description of these fields, please see the Ogg Vorbis specification, section 5.2.2.1.The Ogg Vorbis comment specification does allow these key values to be either upper or lower case. However, it is conventional for them to be upper case. As such, TagLib, when parsing a Xiph/Vorbis comment, converts all fields to uppercase. When you are using this data structure, you will need to specify the field name in upper case.
 # You should not modify this data structure directly, instead use addField() and removeField(). 
 #         
 # 
          def fieldListMap()
          end
 # 
 # Returns the genre name; if no genre is present in the tag String::null will be returned.         
 # 
          def genre()
          end
          def genre=()
          end
 # 
 # Sets the comment to s. If s is String::null then this value will be cleared.         
 # 
          def setComment(s)
          end
 # 
 # Returns the track number; if there is no track number set, this will return 0.         
 # 
          def track()
          end
 # 
 # Returns the vendor ID of the Ogg Vorbis encoder. libvorbis 1.0 as the most common case always returns &quot;Xiph.Org libVorbis I 20020717&quot;.         
 # 
          def vendorID()
          end
        end
 # <b>
 # An implementation of the page headers associated with each Ogg::Page.     .</b>
 # 
 # 
 # This class implements Ogg page headers which contain the information about Ogg pages needed to break them into packets which can be passed on to the codecs.     
 # 
        class TagLib::Ogg::PageHeader
 # 
 # This returns true if this is the first page of the Ogg (logical) stream.setFirstPageOfStream() 
 #         
 # 
          def firstPageOfStream()
          end
 # 
 # A special value of containing the position of the packet to be interpreted by the codec. It is only supported here so that it may be coppied from one page to another.absoluteGranularPosition() 
 #         
 # 
          def setAbsoluteGranularPosition(agp)
          end
 # 
 # Some packets can be continued across multiple pages. If the first packet in the current page is a continuation this will return true. If this is page starts with a new packet this will return false.lastPacketCompleted() setFirstPacketContinued() 
 #         
 # 
          def firstPacketContinued()
          end
 # 
 # Returns the size of the data portion of the page -- i.e. the size of the page less the header size.         
 # 
          def dataSize()
          end
 # 
 # Marks this page as the first page of the Ogg stream.firstPageOfStream() 
 #         
 # 
          def setFirstPageOfStream(first)
          end
 # 
 # Every Ogg logical stream is given a random serial number which is common to every page in that logical stream. This returns the serial number of the stream associated with this packet.setStreamSerialNumber() 
 #         
 # 
          def streamSerialNumber()
          end
 # 
 # Returns the complete header size.         
 # 
          def size()
          end
 # 
 # Sets the internal flag indicating if the first packet in this page is continued to continued.firstPacketContinued() 
 #         
 # 
          def setFirstPacketContinued(continued)
          end
 # 
 # This returns true if this is the last page of the Ogg (logical) stream.setLastPageOfStream() 
 #         
 # 
          def lastPageOfStream()
          end
 # 
 # Every Ogg logical stream is given a random serial number which is common to every page in that logical stream. This sets this pages serial number. This method should be used when adding new pages to a logical stream.streamSerialNumber() 
 #         
 # 
          def setStreamSerialNumber(n)
          end
 # 
 # Returns true if the header parsed properly and is valid.         
 # 
          def isValid()
          end
 # 
 # Render the page header to binary data.The checksum -- bytes 22 - 25 -- will be left empty and must be filled in when rendering the entire page. 
 #         
 # 
          def render()
          end
 # 
 # Returns true if the last packet of this page is completely contained in this page.firstPacketContinued() setLastPacketCompleted() 
 #         
 # 
          def lastPacketCompleted()
          end
 # 
 # Marks this page as the last page of the Ogg stream.lastPageOfStream() 
 #         
 # 
          def setLastPageOfStream(last)
          end
 # 
 # Ogg pages contain a list of packets (which are used by the contained codecs). The sizes of these pages is encoded in the page header. This returns a list of the packet sizes in bytes.setPacketSizes() 
 #         
 # 
          def packetSizes()
          end
 # 
 # Returns the index of the page within the Ogg stream. This helps make it possible to determine if pages have been lost.setPageSequenceNumber() 
 #         
 # 
          def pageSequenceNumber()
          end
 # 
 # Sets the internal flag indicating if the last packet in this page is complete to completed.lastPacketCompleted() 
 #         
 # 
          def setLastPacketCompleted(completed)
          end
 # 
 # A special value of containing the position of the packet to be interpreted by the codec. In the case of Vorbis this contains the PCM value and is used to calculate the length of the stream.setAbsoluteGranularPosition() 
 #         
 # 
          def absoluteGranularPosition()
          end
 # 
 # Sets the sizes of the packets in this page to sizes. Internally this updates the lacing values in the header.packetSizes() 
 #         
 # 
          def setPacketSizes(sizes)
          end
 # 
 # Sets the page&apos;s position in the stream to sequenceNumber.pageSequenceNumber() 
 #         
 # 
          def setPageSequenceNumber(sequenceNumber)
          end
        end
 # <b>
 # An implementation of TagLib::File with some helpers for Ogg based formats.     .</b>
 # 
 # 
 # This is an implementation of Ogg file page and packet rendering and is of use to Ogg based formats. While the API is small this handles the non-trivial details of breaking up an Ogg stream into packets and makes these available (via subclassing) to the codec meta data implementations.     
 # 
        class TagLib::Ogg::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
 # 
 # Returns a pointer to the PageHeader for the last page in the stream or null if the page could not be found.         
 # 
          def lastPageHeader()
          end
          def read_only?()
          end
          def isOpen()
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
          def tag()
          end
          def writeBlock()
          end
 # 
 # Returns the packet contents for the i-th packet (starting from zero) in the Ogg bitstream.The requires reading at least the packet header for every page up to the requested page. 
 #         
 # 
          def packet(i)
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
          def isValid()
          end
          def find1()
          end
 # 
 # Sets the packet with index i to the value p.         
 # 
          def setPacket(i,p)
          end
          def insert()
          end
          def readOnly()
          end
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
 # 
 # Returns a pointer to the PageHeader for the first page in the stream or null if the page could not be found.         
 # 
          def firstPageHeader()
          end
          def length()
          end
          def valid?()
          end
 # 
 # Save the file and its associated tags. This should be reimplemented in the concrete subclasses. Returns true if the save succeeds.On UNIX multiple processes are able to write to the same file at the same time. This can result in serious file corruption. If you are developing a program that makes use of TagLib from multiple processes you must insure that you are only doing writes to a particular file from one of them. 
 #         
 # 
          def save()
          end
        end
 # <b>
 # A namespace containing classes for Speex metadata.     .</b>
 # 
 # 
 #     
 # 
          module TagLib::Ogg::Speex
           # <b>
 # An implementation of audio property reading for Ogg Speex.     .</b>
 # 
 # 
 # This reads the data from an Ogg Speex stream found in the AudioProperties API.     
 # 
            class TagLib::Ogg::Speex::Properties < TagLib::AudioProperties
 # 
 # Returns the Speex version, currently &quot;0&quot; (as specified by the spec).         
 # 
              def speexVersion()
              end
 # 
 # Returns the sample rate in Hz.         
 # 
              def sampleRate()
              end
 # 
 # Returns the number of audio channels.         
 # 
              def channels()
              end
 # 
 # Returns the length of the file in seconds.         
 # 
              def length()
              end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
              def bitrate()
              end
            end
 # <b>
 # An implementation of Ogg::File with Speex specific methods.     .</b>
 # 
 # 
 # This is the central class in the Ogg Speex metadata processing collection of classes. It&apos;s built upon Ogg::File which handles processing of the Ogg logical bitstream and breaking it down into pages which are handled by the codec implementations, in this case Speex specifically.     
 # 
            class TagLib::Ogg::Speex::File < TagLib::Ogg::File
              def isWritable()
              end
              def name()
              end
              def seek()
              end
              def find3()
              end
              def lastPageHeader()
              end
              def read_only?()
              end
              def isOpen()
              end
              def readBlock()
              end
              def rfind()
              end
              def clear()
              end
 # 
 # Returns the XiphComment for this file. XiphComment implements the tag interface, so this serves as the reimplementation of TagLib::File::tag().         
 # 
              def tag()
              end
              def writeBlock()
              end
              def packet()
              end
              def removeBlock()
              end
              def writable?()
              end
              def open?()
              end
              def isValid()
              end
              def find1()
              end
              def setPacket()
              end
              def insert()
              end
              def readOnly()
              end
 # 
 # Returns the Speex::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
              def audioProperties()
              end
              def tell()
              end
              def find2()
              end
              def firstPageHeader()
              end
              def length()
              end
              def valid?()
              end
 # 
 # Save the file and its associated tags. This should be reimplemented in the concrete subclasses. Returns true if the save succeeds.On UNIX multiple processes are able to write to the same file at the same time. This can result in serious file corruption. If you are developing a program that makes use of TagLib from multiple processes you must insure that you are only doing writes to a particular file from one of them. 
 #         
 # 
              def save()
              end
            end
          end
          module TagLib::Ogg::Flac
                      class TagLib::Ogg::Flac::File < TagLib::Ogg::File
              def isWritable()
              end
              def name()
              end
              def seek()
              end
              def find3()
              end
              def lastPageHeader()
              end
              def read_only?()
              end
              def isOpen()
              end
              def readBlock()
              end
              def rfind()
              end
              def clear()
              end
              def tag()
              end
              def writeBlock()
              end
              def packet()
              end
              def removeBlock()
              end
              def writable?()
              end
              def open?()
              end
              def isValid()
              end
              def streamLength()
              end
              def find1()
              end
              def setPacket()
              end
              def insert()
              end
              def readOnly()
              end
              def audioProperties()
              end
              def tell()
              end
              def find2()
              end
              def firstPageHeader()
              end
              def length()
              end
              def valid?()
              end
              def save()
              end
            end
          end
      end
 # <b>
 # An ID3v1 implementation.     .</b>
 # 
 # 
 #     
 # 
      module TagLib::ID3v1
              # Singleton methods
        def self.genreIndex()
        end
        def self.genre()
        end
        def self.genreMap()
        end
        def self.genreList()
        end
 # <b>
 # The main class in the ID3v1 implementation.     .</b>
 # 
 # 
 # This is an implementation of the ID3v1 format. ID3v1 is both the simplist and most common of tag formats but is rather limited. Because of its pervasiveness and the way that applications have been written around the fields that it provides, the generic TagLib::Tag API is a mirror of what is provided by ID3v1.ID3v1 tags should generally only contain Latin1 information. However because many applications do not follow this rule there is now support for overriding the ID3v1 string handling using the ID3v1::StringHandler class. Please see the documentation for that class for more information.StringHandler
 # Most fields are truncated to a maximum of 28-30 bytes. The truncation happens automatically when the tag is rendered. 
 #     
 # 
        class TagLib::ID3v1::Tag < TagLib::Tag
          def track=()
          end
 # 
 # Sets the genre to s. If s is String::null then this value will be cleared. For tag formats that use a fixed set of genres, the appropriate value will be selected based on a string comparison. A list of available genres for those formats should be available in that type&apos;s implementation.         
 # 
          def setGenre(s)
          end
 # 
 # Returns the track name; if no track name is present in the tag String::null will be returned.         
 # 
          def title()
          end
          def title=()
          end
 # 
 # Sets the title to s. If s is String::null then this value will be cleared.         
 # 
          def setTitle(s)
          end
 # 
 # Returns the year; if there is no year set, this will return 0.         
 # 
          def year()
          end
 # 
 # Sets the year to i. If s is 0 then this value will be cleared.         
 # 
          def setYear(i)
          end
 # 
 # Returns the artist name; if no artist name is present in the tag String::null will be returned.         
 # 
          def artist()
          end
          def year=()
          end
          def artist=()
          end
 # 
 # Sets the artist to s. If s is String::null then this value will be cleared.         
 # 
          def setArtist(s)
          end
 # 
 # Returns the track comment; if no comment is present in the tag String::null will be returned.         
 # 
          def comment()
          end
 # 
 # Sets the track to i. If s is 0 then this value will be cleared.         
 # 
          def setTrack(i)
          end
          def comment=()
          end
          def empty?()
          end
 # 
 # Returns the album name; if no album name is present in the tag String::null will be returned.         
 # 
          def album()
          end
 # 
 # Renders the in memory values to a ByteVector suitable for writing to the file.         
 # 
          def render()
          end
          def album=()
          end
 # 
 # Sets the album to s. If s is String::null then this value will be cleared.         
 # 
          def setAlbum(s)
          end
          def isEmpty()
          end
 # 
 # Returns the genre name; if no genre is present in the tag String::null will be returned.         
 # 
          def genre()
          end
          def genre=()
          end
 # 
 # Sets the comment to s. If s is String::null then this value will be cleared.         
 # 
          def setComment(s)
          end
 # 
 # Returns the track number; if there is no track number set, this will return 0.         
 # 
          def track()
          end
        end
      end
 # <b>
 # A namespace containing classes for Vorbis metadata.     .</b>
 # 
 # 
 #     
 # 
      module TagLib::Vorbis
       # <b>
 # An implementation of audio property reading for Ogg Vorbis.     .</b>
 # 
 # 
 # This reads the data from an Ogg Vorbis stream found in the AudioProperties API.     
 # 
        class TagLib::Vorbis::Properties < TagLib::AudioProperties
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns the Vorbis version, currently &quot;0&quot; (as specified by the spec).         
 # 
          def vorbisVersion()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns the maximum bitrate as read from the Vorbis identification header.         
 # 
          def bitrateMaximum()
          end
 # 
 # Returns the nominal bitrate as read from the Vorbis identification header.         
 # 
          def bitrateNominal()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the minimum bitrate as read from the Vorbis identification header.         
 # 
          def bitrateMinimum()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
        end
 # <b>
 # An implementation of Ogg::File with Vorbis specific methods.     .</b>
 # 
 # 
 # This is the central class in the Ogg Vorbis metadata processing collection of classes. It&apos;s built upon Ogg::File which handles processing of the Ogg logical bitstream and breaking it down into pages which are handled by the codec implementations, in this case Vorbis specifically.     
 # 
        class TagLib::Vorbis::File < TagLib::Ogg::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def lastPageHeader()
          end
          def read_only?()
          end
          def isOpen()
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the XiphComment for this file. XiphComment implements the tag interface, so this serves as the reimplementation of TagLib::File::tag().         
 # 
          def tag()
          end
          def writeBlock()
          end
          def packet()
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
          def isValid()
          end
          def find1()
          end
          def setPacket()
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the Vorbis::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
          def firstPageHeader()
          end
          def length()
          end
          def valid?()
          end
 # 
 # Save the file and its associated tags. This should be reimplemented in the concrete subclasses. Returns true if the save succeeds.On UNIX multiple processes are able to write to the same file at the same time. This can result in serious file corruption. If you are developing a program that makes use of TagLib from multiple processes you must insure that you are only doing writes to a particular file from one of them. 
 #         
 # 
          def save()
          end
        end
      end
 # <b>
 # An implementation of TagLib::File with MPEG (MP3) specific methods.     .</b>
 # 
 # 
 #     
 # 
      module TagLib::MPEG
       # <b>
 # An implementation of the Xing VBR headers.     .</b>
 # 
 # 
 # This is a minimalistic implementation of the Xing VBR headers. Xing headers are often added to VBR (variable bit rate) MP3 streams to make it easy to compute the length and quality of a VBR stream. Our implementation is only concerned with the total size of the stream (so that we can calculate the total playing time and the average bitrate). It uses this text and the XMMS sources as references.     
 # 
        class TagLib::MPEG::XingHeader
 # 
 # Returns true if the data was parsed properly and if there is a valid Xing header present.         
 # 
          def isValid()
          end
 # 
 # Returns the total number of frames.         
 # 
          def totalFrames()
          end
 # 
 # Returns the total size of stream in bytes.         
 # 
          def totalSize()
          end
        end
 # <b>
 # An implementation of audio property reading for MP3.     .</b>
 # 
 # 
 # This reads the data from an MPEG Layer III stream found in the AudioProperties API.     
 # 
        class TagLib::MPEG::Properties < TagLib::AudioProperties
 # 
 # Returns a pointer to the XingHeader if one exists or null if no XingHeader was found.         
 # 
          def xingHeader()
          end
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns the MPEG Version of the file.         
 # 
          def version()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns the channel mode for this frame.         
 # 
          def channelMode()
          end
 # 
 # Returns true if the copyrighted bit is set.         
 # 
          def isCopyrighted()
          end
 # 
 # Returns the layer version. This will be between the values 1-3.         
 # 
          def layer()
          end
 # 
 # Returns true if the &quot;original&quot; bit is set.         
 # 
          def isOriginal()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
 # 
 # Returns true if the MPEG protection bit is enabled.         
 # 
          def protectionEnabled()
          end
        end
 # <b>
 # An implementation of MP3 frame headers.     .</b>
 # 
 # 
 # This is an implementation of MPEG Layer III headers. The API follows more or less the binary format of these headers. I&apos;ve used this document as a reference.     
 # 
        class TagLib::MPEG::Header
 # 
 # Returns the frame length.         
 # 
          def frameLength()
          end
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns true if the frame is padded.         
 # 
          def isPadded()
          end
 # 
 # Returns the MPEG Version of the header.         
 # 
          def version()
          end
 # 
 # Returns the number of frames per sample.         
 # 
          def samplesPerFrame()
          end
 # 
 # Returns the channel mode for this frame.         
 # 
          def channelMode()
          end
 # 
 # Returns true if the frame is at least an appropriate size and has legal values.         
 # 
          def isValid()
          end
 # 
 # Returns true if the copyrighted bit is set.         
 # 
          def isCopyrighted()
          end
 # 
 # Returns the layer version. This will be between the values 1-3.         
 # 
          def layer()
          end
 # 
 # Returns true if the &quot;original&quot; bit is set.         
 # 
          def isOriginal()
          end
 # 
 # Returns the bitrate encoded in the header.         
 # 
          def bitrate()
          end
 # 
 # Returns true if the MPEG protection bit is enabled.         
 # 
          def protectionEnabled()
          end
        end
 # <b>
 # An MPEG file class with some useful methods specific to MPEG.     .</b>
 # 
 # 
 # This implements the generic TagLib::File API and additionally provides access to properties that are distinct to MPEG files, notably access to the different ID3 tags.     
 # 
        class TagLib::MPEG::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def read_only?()
          end
          def isOpen()
          end
 # 
 # Returns a pointer to the ID3v1 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v1 tag. If create is true it will create an ID3v1 tag if one does not exist.The Tag is still owned by the MPEG::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v1Tag(create = false)
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the position in the file of the first MPEG frame.         
 # 
          def firstFrameOffset()
          end
 # 
 # Returns a pointer to a tag that is the union of the ID3v2 and ID3v1 tags. The ID3v2 tag is given priority in reading the information -- if requested information exists in both the ID3v2 tag and the ID3v1 tag, the information from the ID3v2 tag will be returned.If you would like more granular control over the content of the tags, with the concession of generality, use the tag-type specific calls.As this tag is not implemented as an ID3v2 tag or an ID3v1 tag, but a union of the two this pointer may not be cast to the specific tag types.
 # ID3v1Tag() ID3v2Tag() APETag() 
 #         
 # 
          def tag()
          end
          def writeBlock()
          end
 # 
 # Set the ID3v2::FrameFactory to something other than the default.ID3v2FrameFactory 
 #         
 # 
          def setID3v2FrameFactory(factory)
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
 # 
 # Returns the position in the file of the next MPEG frame, using the current position as start         
 # 
          def nextFrameOffset(position)
          end
 # 
 # This will strip the tags that match the OR-ed together TagTypes from the file. By default it strips all tags. It returns true if the tags are successfully stripped.If freeMemory is true the ID3 and APE tags will be deleted and pointers to them will be invalidated.         
 # 
          def strip(tags,freeMemory)
          end
          def isValid()
          end
          def find1()
          end
 # 
 # Returns a pointer to the APE tag of the file.If create is false (the default) this will return a null pointer if there is no valid APE tag. If create is true it will create an APE tag if one does not exist.The Tag is still owned by the MPEG::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def APETag(create = false)
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the MPEG::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
 # 
 # Returns the position in the file of the previous MPEG frame, using the current position as start         
 # 
          def previousFrameOffset(position)
          end
          def tell()
          end
          def find2()
          end
          def length()
          end
 # 
 # Returns a pointer to the ID3v2 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v2 tag. If create is true it will create an ID3v2 tag if one does not exist.The Tag is still owned by the MPEG::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v2Tag(create = false)
          end
          def valid?()
          end
 # 
 # Save the file. This will attempt to save all of the tag types that are specified by OR-ing together TagTypes values. The save() method above uses AllTags. This returns true if saving was successful.If stripOthers is true this strips all tags not included in the mask, but does not modify them in memory, so later calls to save() which make use of these tags will remain valid. This also strips empty tags.         
 # 
          def save(tags,stripOthers)
          end
 # 
 # Returns the position in the file of the last MPEG frame.         
 # 
          def lastFrameOffset()
          end
        end
      end
 # <b>
 # An implementation of the APE tagging format.     .</b>
 # 
 # 
 #     
 # 
      module TagLib::APE
       # <b>
 # An implementation of APE-items.     .</b>
 # 
 # 
 # This class provides the features of items in the APEv2 standard.     
 # 
        class TagLib::APE::Item
 # 
 # Returns the key.         
 # 
          def key()
          end
 # 
 # Return true if the item is read-only.         
 # 
          def isReadOnly()
          end
 # 
 # Returns the binary value.DeprecatedThis will be removed in the next binary incompatible version as it is not kept in sync with the things that are set using setValue() and friends.         
 # 
          def value()
          end
 # 
 # Sets the key for the item to key.         
 # 
          def setKey(key)
          end
 # 
 # Returns the list of values.         
 # 
          def values()
          end
 # 
 # Returns the value as a single string. In case of multiple strings, the first is returned.         
 # 
          def toString()
          end
 # 
 # Sets the type of the item to type.ItemTypes 
 #         
 # 
          def setType(type)
          end
 # 
 # Sets the value of the item to value and clears any previous contents.toString() 
 #         
 # 
          def setValue(value)
          end
 # 
 # Deprecatedvalues 
 #         
 # 
          def toStringList()
          end
 # 
 # Returns the size of the full item.         
 # 
          def size()
          end
 # 
 # Sets the value of the item to the list of values in value and clears any previous contents.toStringList() 
 #         
 # 
          def setValues(values)
          end
 # 
 # Render the item to a ByteVector.         
 # 
          def render()
          end
 # 
 # Parse the item from the ByteVector data.         
 # 
          def parse(data)
          end
 # 
 # Returns if the item has any real content.         
 # 
          def isEmpty()
          end
 # 
 # Appends value to create (or extend) the current list of values.toString() 
 #         
 # 
          def appendValue(value)
          end
 # 
 # Set the item to read-only.         
 # 
          def setReadOnly(readOnly)
          end
 # 
 # Appends values to extend the current list of values.toStringList() 
 #         
 # 
          def appendValues(values)
          end
        end
 # <b>
 # An implementation of APE footers.     .</b>
 # 
 # 
 # This class implements APE footers (and headers). It attempts to follow, both semantically and programatically, the structure specified in the APE v2.0 standard. The API is based on the properties of APE footer and headers specified there.     
 # 
        class TagLib::APE::Footer
 # 
 # Returns true if a footer is present in the tag.         
 # 
          def footerPresent()
          end
 # 
 # Returns the tag size in bytes. This is the size of the frame content and footer. The size of the entire tag will be this plus the header size, if present.completeTagSize() 
 #         
 # 
          def tagSize()
          end
 # 
 # Renders the header corresponding to the footer. If headerPresent is set to false, it returns an empty ByteVector.         
 # 
          def renderHeader()
          end
 # 
 # Returns the version number. (Note: This is the 1000 or 2000.)         
 # 
          def version()
          end
 # 
 # Returns true this is actually the header.         
 # 
          def isHeader()
          end
 # 
 # Returns the tag size, including if present, the header size.tagSize() 
 #         
 # 
          def completeTagSize()
          end
 # 
 # Sets whether the header should be rendered or not         
 # 
          def setHeaderPresent(b)
          end
 # 
 # Set the tag size to s. tagSize() 
 #         
 # 
          def setTagSize(s)
          end
 # 
 # Returns the number of items in the tag.         
 # 
          def itemCount()
          end
 # 
 # Sets the data that will be used as the footer. 32 bytes, starting from data will be used.         
 # 
          def setData(data)
          end
 # 
 # Returns true if a header is present in the tag.         
 # 
          def headerPresent()
          end
 # 
 # Set the item count to s. itemCount() 
 #         
 # 
          def setItemCount(s)
          end
 # 
 # Renders the footer back to binary format.         
 # 
          def renderFooter()
          end
        end
 # <b>
 # An APE tag implementation.     .</b>
 # 
 # 
 #     
 # 
        class TagLib::APE::Tag < TagLib::Tag
          def track=()
          end
 # 
 # Sets the genre to s. If s is String::null then this value will be cleared. For tag formats that use a fixed set of genres, the appropriate value will be selected based on a string comparison. A list of available genres for those formats should be available in that type&apos;s implementation.         
 # 
          def setGenre(s)
          end
 # 
 # Returns the track name; if no track name is present in the tag String::null will be returned.         
 # 
          def title()
          end
 # 
 # Adds to the item specified by key the data value. If replace is true, then all of the other values on the same key will be removed first.         
 # 
          def addValue(key,value,replace = true)
          end
          def title=()
          end
 # 
 # Sets the title to s. If s is String::null then this value will be cleared.         
 # 
          def setTitle(s)
          end
 # 
 # Returns the year; if there is no year set, this will return 0.         
 # 
          def year()
          end
 # 
 # Sets the year to i. If s is 0 then this value will be cleared.         
 # 
          def setYear(i)
          end
 # 
 # Sets the key item to the value of item. If an item with the key is already present, it will be replaced.         
 # 
          def setItem(key,item)
          end
 # 
 # Returns the artist name; if no artist name is present in the tag String::null will be returned.         
 # 
          def artist()
          end
          def year=()
          end
          def artist=()
          end
 # 
 # Sets the artist to s. If s is String::null then this value will be cleared.         
 # 
          def setArtist(s)
          end
 # 
 # Returns the track comment; if no comment is present in the tag String::null will be returned.         
 # 
          def comment()
          end
 # 
 # Returns a pointer to the tag&apos;s footer.         
 # 
          def footer()
          end
 # 
 # Sets the track to i. If s is 0 then this value will be cleared.         
 # 
          def setTrack(i)
          end
          def comment=()
          end
          def empty?()
          end
 # 
 # Returns the album name; if no album name is present in the tag String::null will be returned.         
 # 
          def album()
          end
 # 
 # Renders the in memory values to a ByteVector suitable for writing to the file.         
 # 
          def render()
          end
          def album=()
          end
 # 
 # Sets the album to s. If s is String::null then this value will be cleared.         
 # 
          def setAlbum(s)
          end
 # 
 # Returns a reference to the item list map. This is an ItemListMap of all of the items in the tag.This is the most powerfull structure for accessing the items of the tag.You should not modify this data structure directly, instead use setItem() and removeItem(). 
 #         
 # 
          def itemListMap()
          end
          def isEmpty()
          end
 # 
 # Returns the genre name; if no genre is present in the tag String::null will be returned.         
 # 
          def genre()
          end
          def genre=()
          end
 # 
 # Sets the comment to s. If s is String::null then this value will be cleared.         
 # 
          def setComment(s)
          end
 # 
 # Removes the key item from the tag         
 # 
          def removeItem(key)
          end
 # 
 # Returns the track number; if there is no track number set, this will return 0.         
 # 
          def track()
          end
        end
      end
 # <b>
 # An implementation of MPC metadata.     .</b>
 # 
 # 
 # This is implementation of MPC metadata.This supports ID3v1 and APE (v1 and v2) style comments as well as reading stream properties from the file. ID3v2 tags are invalid in MPC-files, but will be skipped and ignored.     
 # 
      module TagLib::MPC
       # <b>
 # An implementation of audio property reading for MPC.     .</b>
 # 
 # 
 # This reads the data from an MPC stream found in the AudioProperties API.     
 # 
        class TagLib::MPC::Properties < TagLib::AudioProperties
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
 # 
 # Returns the version of the bitstream (SV4-SV7)         
 # 
          def mpcVersion()
          end
        end
 # <b>
 # An implementation of TagLib::File with MPC specific methods.     .</b>
 # 
 # 
 # This implements and provides an interface for MPC files to the TagLib::Tag and TagLib::AudioProperties interfaces by way of implementing the abstract TagLib::File API as well as providing some additional information specific to MPC files. The only invalid tag combination supported is an ID3v1 tag after an APE tag.     
 # 
        class TagLib::MPC::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def read_only?()
          end
          def isOpen()
          end
 # 
 # Returns a pointer to the ID3v1 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v1 tag. If create is true it will create an ID3v1 tag if one does not exist. If there is already an APE tag, the new ID3v1 tag will be placed after it.The Tag is still owned by the APE::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v1Tag(create = false)
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the Tag for this file. This will be an APE tag, an ID3v1 tag or a combination of the two.         
 # 
          def tag()
          end
          def writeBlock()
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
 # 
 # This will remove the tags that match the OR-ed together TagTypes from the file. By default it removes all tags.This will also invalidate pointers to the tags as their memory will be freed.
 # In order to make the removal permanent save() still needs to be called. 
 #         
 # 
          def strip(tags = AllTags)
          end
          def isValid()
          end
 # 
 # Deprecatedstrip 
 #         
 # 
          def remove(tags = AllTags)
          end
          def find1()
          end
 # 
 # Returns a pointer to the APE tag of the file.If create is false (the default) this will return a null pointer if there is no valid APE tag. If create is true it will create a APE tag if one does not exist. If there is already an ID3v1 tag, thes new APE tag will be placed before it.The Tag is still owned by the APE::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def APETag(create = false)
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the MPC::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
          def length()
          end
          def valid?()
          end
 # 
 # Saves the file.         
 # 
          def save()
          end
        end
      end
 # <b>
 # An implementation of FLAC metadata.     .</b>
 # 
 # 
 # This is implementation of FLAC metadata for non-Ogg FLAC files. At some point when Ogg / FLAC is more common there will be a similar implementation under the Ogg hiearchy.This supports ID3v1, ID3v2 and Xiph style comments as well as reading stream properties from the file.     
 # 
      module TagLib::FLAC
       # <b>
 # An implementation of audio property reading for FLAC.     .</b>
 # 
 # 
 # This reads the data from an FLAC stream found in the AudioProperties API.     
 # 
        class TagLib::FLAC::Properties < TagLib::AudioProperties
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns the sample width as read from the FLAC identification header.         
 # 
          def sampleWidth()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
        end
 # <b>
 # An implementation of TagLib::File with FLAC specific methods.     .</b>
 # 
 # 
 # This implements and provides an interface for FLAC files to the TagLib::Tag and TagLib::AudioProperties interfaces by way of implementing the abstract TagLib::File API as well as providing some additional information specific to FLAC files.     
 # 
        class TagLib::FLAC::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def read_only?()
          end
          def isOpen()
          end
 # 
 # Returns a pointer to the ID3v1 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v1 tag. If create is true it will create an ID3v1 tag if one does not exist.The Tag is still owned by the FLAC::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v1Tag(create = false)
          end
          def readBlock()
          end
 # 
 # Returns a pointer to the XiphComment for the file.If create is false (the default) this will return a null pointer if there is no valid XiphComment. If create is true it will create a XiphComment if one does not exist.The Tag is still owned by the FLAC::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def xiphComment(create = false)
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the Tag for this file. This will be a union of XiphComment, ID3v1 and ID3v2 tags.ID3v2Tag() ID3v1Tag() XiphComment() 
 #         
 # 
          def tag()
          end
          def writeBlock()
          end
 # 
 # Set the ID3v2::FrameFactory to something other than the default. This can be used to specify the way that ID3v2 frames will be interpreted whenID3v2FrameFactory 
 #         
 # 
          def setID3v2FrameFactory(factory)
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
          def isValid()
          end
 # 
 # Returns the length of the audio-stream, used by FLAC::Properties for calculating the bitrate.DeprecatedThis method will not be public in a future release.         
 # 
          def streamLength()
          end
          def find1()
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the block of data used by FLAC::Properties for parsing the stream properties.DeprecatedThis method will not be public in a future release.         
 # 
          def streamInfoData()
          end
 # 
 # Returns the FLAC::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
          def length()
          end
 # 
 # Returns a pointer to the ID3v2 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v2 tag. If create is true it will create an ID3v2 tag if one does not exist.The Tag is still owned by the FLAC::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v2Tag(create = false)
          end
          def valid?()
          end
 # 
 # Save the file. This will primarily save the XiphComment, but will also keep any old ID3-tags up to date. If the file has no XiphComment, one will be constructed from the ID3-tags.This returns true if the save was successful.         
 # 
          def save()
          end
        end
      end
 # <b>
 # An implementation of WavPack metadata.     .</b>
 # 
 # 
 # This is implementation of WavPack metadata.This supports ID3v1 and APE (v1 and v2) style comments as well as reading stream properties from the file.     
 # 
      module TagLib::WavPack
       # <b>
 # An implementation of audio property reading for WavPack.     .</b>
 # 
 # 
 # This reads the data from an WavPack stream found in the AudioProperties API.     
 # 
        class TagLib::WavPack::Properties < TagLib::AudioProperties
 # 
 # Returns the sample rate in Hz.         
 # 
          def sampleRate()
          end
 # 
 # Returns WavPack version.         
 # 
          def version()
          end
 # 
 # Returns the number of audio channels.         
 # 
          def channels()
          end
 # 
 # Returns number of bits per sample.         
 # 
          def bitsPerSample()
          end
 # 
 # Returns the length of the file in seconds.         
 # 
          def length()
          end
 # 
 # Returns the most appropriate bit rate for the file in kb/s. For constant bitrate formats this is simply the bitrate of the file. For variable bitrate formats this is either the average or nominal bitrate.         
 # 
          def bitrate()
          end
        end
 # <b>
 # An implementation of TagLib::File with WavPack specific methods.     .</b>
 # 
 # 
 # This implements and provides an interface for WavPack files to the TagLib::Tag and TagLib::AudioProperties interfaces by way of implementing the abstract TagLib::File API as well as providing some additional information specific to WavPack files.     
 # 
        class TagLib::WavPack::File < TagLib::File
          def isWritable()
          end
          def name()
          end
          def seek()
          end
          def find3()
          end
          def read_only?()
          end
          def isOpen()
          end
 # 
 # Returns a pointer to the ID3v1 tag of the file.If create is false (the default) this will return a null pointer if there is no valid ID3v1 tag. If create is true it will create an ID3v1 tag if one does not exist. If there is already an APE tag, the new ID3v1 tag will be placed after it.The Tag is still owned by the APE::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def ID3v1Tag(create = false)
          end
          def readBlock()
          end
          def rfind()
          end
          def clear()
          end
 # 
 # Returns the Tag for this file. This will be an APE tag, an ID3v1 tag or a combination of the two.         
 # 
          def tag()
          end
          def writeBlock()
          end
          def removeBlock()
          end
          def writable?()
          end
          def open?()
          end
 # 
 # This will remove the tags that match the OR-ed together TagTypes from the file. By default it removes all tags.This will also invalidate pointers to the tags as their memory will be freed. In order to make the removal permanent save() still needs to be called 
 #         
 # 
          def strip(tags = AllTags)
          end
          def isValid()
          end
          def find1()
          end
 # 
 # Returns a pointer to the APE tag of the file.If create is false (the default) this will return a null pointer if there is no valid APE tag. If create is true it will create a APE tag if one does not exist.The Tag is still owned by the APE::File and should not be deleted by the user. It will be deleted when the file (object) is destroyed. 
 #         
 # 
          def APETag(create = false)
          end
          def insert()
          end
          def readOnly()
          end
 # 
 # Returns the MPC::Properties for this file. If no audio properties were read then this will return a null pointer.         
 # 
          def audioProperties()
          end
          def tell()
          end
          def find2()
          end
          def length()
          end
          def valid?()
          end
 # 
 # Saves the file.         
 # 
          def save()
          end
        end
      end
 # <b>
 # An ID3v2 implementation.     .</b>
 # 
 # 
 # This is a relatively complete and flexible framework for working with ID3v2 tags.ID3v2::Tag 
 #     
 # 
      module TagLib::ID3v2
       # <b>
 # An implementation of ID3v2 comments.     .</b>
 # 
 # 
 # This implements the ID3v2 comment format. An ID3v2 comment concists of a language encoding, a description and a single text field.     
 # 
        class TagLib::ID3v2::CommentsFrame < TagLib::ID3v2::Frame
 # 
 # Sets the description of the comment to s.decription() 
 #         
 # 
          def setDescription(s)
          end
 # 
 # Sets the text portion of the comment to s.text() 
 #         
 # 
          def setText(s)
          end
 # 
 # Returns the text of this comment.text() 
 #         
 # 
          def toString()
          end
 # 
 # Returns the text encoding that will be used in rendering this frame. This defaults to the type that was either specified in the constructor or read from the frame when parsed.setTextEncoding() render() 
 #         
 # 
          def textEncoding()
          end
          def frameID()
          end
 # 
 # Returns the description of this comment.Most taggers simply ignore this value.
 # setDescription() 
 #         
 # 
          def description()
          end
          def size()
          end
 # 
 # Sets the text encoding to be used when rendering this frame to encoding.textEncoding() render() 
 #         
 # 
          def setTextEncoding(encoding)
          end
 # 
 # Returns the text of this comment.setText() 
 #         
 # 
          def text()
          end
 # 
 # Returns the language encoding as a 3 byte encoding as specified by ISO-639-2.Most taggers simply ignore this value.
 # setLanguage() 
 #         
 # 
          def language()
          end
 # 
 # Set the language using the 3 byte language code from ISO-639-2 to languageCode.language() 
 #         
 # 
          def setLanguage(languageCode)
          end
        end
 # <b>
 # An ID3v2 general encapsulated object frame implementation.     .</b>
 # 
 # 
 # This is an implementation of ID3v2 general encapsulated objects. Arbitrary binary data may be included in tags, stored in GEOB frames. There may be multiple GEOB frames in a single tag. Each GEOB it labelled with a content description (which may be blank), a required mime-type, and a file name (may be blank). The content description uniquely identifies the GEOB frame in the tag.     
 # 
        class TagLib::ID3v2::GeneralEncapsulatedObjectFrame
        end
 # <b>
 # ID3v2 frame implementation.     .</b>
 # 
 # 
 # ID3v2 frame header implementation.This class is the main ID3v2 frame implementation. In ID3v2, a tag is split between a collection of frames (which are in turn split into fields (Structure, 4) (Frames). This class provides an API for gathering information about and modifying ID3v2 frames. Funtionallity specific to a given frame type is handed in one of the many subclasses.The ID3v2 Frame Header (Structure, 4)Every ID3v2::Frame has an associated header that gives some general properties of the frame and also makes it possible to identify the frame type.As such when reading an ID3v2 tag ID3v2::FrameFactory first creates the frame headers and then creates the appropriate Frame subclass based on the type and attaches the header.     
 # 
        class TagLib::ID3v2::Frame < TagLib::ID3v2::Header
 # 
 # Returns the Frame ID (Structure, 4) (Frames, 4)         
 # 
          def frameID()
          end
 # 
 # Returns the size of the frame.         
 # 
          def size()
          end
        end
 # <b>
 # An implementation of ID3v2 headers.     .</b>
 # 
 # 
 # This class implements ID3v2 headers. It attempts to follow, both semantically and programatically, the structure specified in the ID3v2 standard. The API is based on the properties of ID3v2 headers specified there. If any of the terms used in this documentation are unclear please check the specification in the linked section. (Structure, 3.1)     
 # 
        class TagLib::ID3v2::Header
        end
 # <b>
 # An ID3v2 attached picture frame implementation.     .</b>
 # 
 # 
 # This is an implementation of ID3v2 attached pictures. Pictures may be included in tags, one per APIC frame (but there may be multiple APIC frames in a single tag). These pictures are usually in either JPEG or PNG format.     
 # 
        class TagLib::ID3v2::AttachedPictureFrame < TagLib::ID3v2::Frame
          # Singleton methods
          def self.new2()
          end
 # 
 # Sets a textual description of the image to desc.description() textEncoding() setTextEncoding() 
 #         
 # 
          def setDescription(desc)
          end
 # 
 # Returns a string containing the description and mime-type         
 # 
          def toString()
          end
 # 
 # Returns the text encoding used for the description.setTextEncoding() description() 
 #         
 # 
          def textEncoding()
          end
          def frameID()
          end
 # 
 # Sets the type for the image.Type type() 
 #         
 # 
          def setType(t)
          end
 # 
 # Returns the image data as a ByteVector.ByteVector has a data() method that returns a const char * which should make it easy to export this data to external programs.
 # setPicture() mimeType() 
 #         
 # 
          def picture()
          end
 # 
 # Returns a text description of the image.setDescription() textEncoding() setTextEncoding() 
 #         
 # 
          def description()
          end
          def size()
          end
 # 
 # Set the text encoding used for the description.description() 
 #         
 # 
          def setTextEncoding(t)
          end
 # 
 # Sets the image data to p. p should be of the type specified in this frame&apos;s mime-type specification.picture() mimeType() setMimeType() 
 #         
 # 
          def setPicture(p)
          end
 # 
 # Returns the mime type of the image. This should in most cases be &quot;image/png&quot; or &quot;image/jpeg&quot;.         
 # 
          def mimeType()
          end
 # 
 # Sets the mime type of the image. This should in most cases be &quot;image/png&quot; or &quot;image/jpeg&quot;.         
 # 
          def setMimeType(m)
          end
        end
 # <b>
 # A factory for creating ID3v2 frames during parsing.     .</b>
 # 
 # 
 # This factory abstracts away the frame creation process and instantiates the appropriate ID3v2::Frame subclasses based on the contents of the data.Reimplementing this factory is the key to adding support for frame types not directly supported by TagLib to your application. To do so you would subclass this factory reimplement createFrame(). Then by setting your factory to be the default factory in ID3v2::Tag constructor or with MPEG::File::setID3v2FrameFactory() you can implement behavior that will allow for new ID3v2::Frame subclasses (also provided by you) to be used.This implements both abstract factory and singleton patterns of which more information is available on the web and in software design textbooks (Notably Design Patters).You do not need to use this factory to create new frames to add to an ID3v2::Tag. You can instantiate frame subclasses directly (with new) and add them to a tag using ID3v2::Tag::addFrame()
 # ID3v2::Tag::addFrame() 
 #     
 # 
        class TagLib::ID3v2::FrameFactory
        end
 # <b>
 # The main class in the ID3v2 implementation.     .</b>
 # 
 # 
 # This is the main class in the ID3v2 implementation. It serves two functions. This first, as is obvious from the public API, is to provide a container for the other ID3v2 related classes. In addition, through the read() and parse() protected methods, it provides the most basic level of parsing. In these methods the ID3v2 tag is extracted from the file and split into data components.ID3v2 tags have several parts, TagLib attempts to provide an interface for them all. header(), footer() and extendedHeader() corespond to those data structures in the ID3v2 standard and the APIs for the classes that they return attempt to reflect this.Also ID3v2 tags are built up from a list of frames, which are in turn have a header and a list of fields. TagLib provides two ways of accessing the list of frames that are in a given ID3v2 tag. The first is simply via the frameList() method. This is just a list of pointers to the frames. The second is a map from the frame type -- i.e. &quot;COMM&quot; for comments -- and a list of frames of that type. (In some cases ID3v2 allows for multiple frames of the same type, hence this being a map to a list rather than just a map to an individual frame.)More information on the structure of frames can be found in the ID3v2::Frame class.read() and parse() pass binary data to the other ID3v2 class structures, they do not handle parsing of flags or fields, for instace. Those are handled by similar functions within those classes.All pointers to data structures within the tag will become invalid when the tag is destroyed.
 # Dealing with the nasty details of ID3v2 is not for the faint of heart and should not be done without much meditation on the spec. It&apos;s rather long, but if you&apos;re planning on messing with this class and others that deal with the details of ID3v2 (rather than the nice, safe, abstract TagLib::Tag and friends), it&apos;s worth your time to familiarize yourself with said spec (which is distrubuted with the TagLib sources). TagLib tries to do most of the work, but with a little luck, you can still convince it to generate invalid ID3v2 tags. The APIs for ID3v2 assume a working knowledge of ID3v2 structure. You&apos;re been warned. 
 #     
 # 
        class TagLib::ID3v2::Tag < TagLib::Tag
          def track=()
          end
 # 
 # Sets the genre to s. If s is String::null then this value will be cleared. For tag formats that use a fixed set of genres, the appropriate value will be selected based on a string comparison. A list of available genres for those formats should be available in that type&apos;s implementation.         
 # 
          def setGenre(s)
          end
 # 
 # Returns the track name; if no track name is present in the tag String::null will be returned.         
 # 
          def title()
          end
 # 
 # Returns a pointer to the tag&apos;s header.         
 # 
          def header()
          end
          def title=()
          end
 # 
 # Sets the title to s. If s is String::null then this value will be cleared.         
 # 
          def setTitle(s)
          end
 # 
 # Returns the frame list for frames with the id frameID or an empty list if there are no frames of that type. This is just a convenience and is equivalent to:frameListMap()[frameID];
 # frameListMap() 
 #         
 # 
          def frameList(frameID)
          end
 # 
 # Returns the year; if there is no year set, this will return 0.         
 # 
          def year()
          end
 # 
 # Sets the year to i. If s is 0 then this value will be cleared.         
 # 
          def setYear(i)
          end
 # 
 # Returns the artist name; if no artist name is present in the tag String::null will be returned.         
 # 
          def artist()
          end
          def year=()
          end
          def artist=()
          end
 # 
 # Sets the artist to s. If s is String::null then this value will be cleared.         
 # 
          def setArtist(s)
          end
 # 
 # Returns the track comment; if no comment is present in the tag String::null will be returned.         
 # 
          def comment()
          end
 # 
 # Remove a frame from the tag. If del is true the frame&apos;s memory will be freed; if it is false, it must be deleted by the user.Using this method will invalidate any pointers on the list returned by frameList() 
 #         
 # 
          def removeFrame(frame,del = true)
          end
 # 
 # Sets the track to i. If s is 0 then this value will be cleared.         
 # 
          def setTrack(i)
          end
          def comment=()
          end
          def empty?()
          end
 # 
 # Returns the album name; if no album name is present in the tag String::null will be returned.         
 # 
          def album()
          end
          def album=()
          end
 # 
 # Sets the album to s. If s is String::null then this value will be cleared.         
 # 
          def setAlbum(s)
          end
 # 
 # Returns true if the tag does not contain any data. This should be reimplemented in subclasses that provide more than the basic tagging abilities in this class.         
 # 
          def isEmpty()
          end
 # 
 # Returns the genre name; if no genre is present in the tag String::null will be returned.         
 # 
          def genre()
          end
 # 
 # Add a frame to the tag. At this point the tag takes ownership of the frame and will handle freeing its memory.Using this method will invalidate any pointers on the list returned by frameList() 
 #         
 # 
          def addFrame(frame)
          end
          def genre=()
          end
 # 
 # Sets the comment to s. If s is String::null then this value will be cleared.         
 # 
          def setComment(s)
          end
 # 
 # Returns the track number; if there is no track number set, this will return 0.         
 # 
          def track()
          end
 # 
 # Returns a reference to the frame list map. This is an FrameListMap of all of the frames in the tag.This is the most convenient structure for accessing the tag&apos;s frames. Many frame types allow multiple instances of the same frame type so this is a map of lists. In most cases however there will only be a single frame of a certain type.Let&apos;s say for instance that you wanted to access the frame for total beats per minute -- the TBPM frame.TagLib::MPEG::Filef(&quot;foo.mp3&quot;);
 # 
 # //ChecktomakesurethatithasanID3v2tag
 # 
 # if(f.ID3v2Tag()){
 # 
 # //Getthelistofframesforaspecificframetype
 # 
 # TagLib::ID3v2::FrameListl=f.ID3v2Tag()-&gt;frameListMap()[&quot;TBPM&quot;];
 # 
 # if(!l.isEmpty())
 # std::cout&lt;&lt;l.front()-&gt;toString()&lt;&lt;std::endl;
 # }
 # You should not modify this data structure directly, instead use addFrame() and removeFrame().
 # frameList() 
 #         
 # 
          def frameListMap()
          end
        end
      end
  end
