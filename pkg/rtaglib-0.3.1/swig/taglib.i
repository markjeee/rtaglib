%module TagLib
%{
#include "taglib/tlist.h"
#include "taglib/fileref.h"
#include "taglib/id3v1tag.h"
#include "taglib/id3v1genres.h"


#include "taglib/id3v2tag.h"
#include "taglib/attachedpictureframe.h"
#include "taglib/commentsframe.h"
#include <taglib/xingheader.h>

#include "taglib/apefooter.h"
#include "taglib/apetag.h"
#include "taglib/apeitem.h"

#include "taglib/mpcfile.h"
#include "taglib/mpcproperties.h"



#include "taglib/flacfile.h"
#include "taglib/flacproperties.h"

#include <taglib/oggpage.h>
#include <taglib/oggpageheader.h>
#include <taglib/oggflacfile.h>
#include <taglib/speexfile.h>
#include <taglib/speexproperties.h>



#include "taglib/vorbisfile.h"
#include "taglib/vorbisproperties.h"

#include "taglib/xiphcomment.h"
#include "taglib/mpegfile.h"


#include "taglib/trueaudiofile.h"
#include "taglib/trueaudioproperties.h"


#include "taglib/wavpackfile.h"
#include "taglib/wavpackproperties.h"

%}

%inline %{
typedef wchar_t 	wchar;
typedef unsigned char 	uchar;
typedef unsigned int 	uint;
typedef unsigned long 	ulong;
typedef std::basic_string< wchar > 	wstring;
typedef const char * 	FileName;
%}


%{
    VALUE ByteVector2Ruby(const TagLib::ByteVector *bv) {
        return rb_tainted_str_new(bv->data(),bv->size());;
    }
    VALUE String2Ruby(const TagLib::String *st) {
        return rb_tainted_str_new2(st->toCString(!st->isLatin1()));
    }
    
    VALUE StringList2Ruby(const TagLib::StringList *st) {
        VALUE ary=Qnil;
        if(st->size()>0) {
            ary=rb_ary_new2(st->size());
            for(uint i=0;i<(st->size());i++) {
                const TagLib::String *val=&(st->operator[](i));
                rb_ary_push(ary, String2Ruby(val));
            }
        }
        return ary;
    }
    VALUE FrameList2Ruby(const TagLib::ID3v2::FrameList *st) {
        VALUE ary=Qnil;
        if(st->size()>0) {
            ary=rb_ary_new2(st->size());
            for(uint i=0;i<(st->size());i++) {
            rb_ary_push(ary, SWIG_NewPointerObj(st->operator[](i), SWIGTYPE_p_TagLib__ID3v2__Frame, 0));
            }
        }
        return ary;
    }
    
%}

%init %{
    VALUE mTagLibFLAC = rb_define_module_under(mTagLib, "FLAC");
    VALUE mTagLibAPE = rb_define_module_under(mTagLib, "APE");
    VALUE mTagLibID3v1 = rb_define_module_under(mTagLib, "ID3v1");
    VALUE mTagLibID3v2 = rb_define_module_under(mTagLib, "ID3v2");
    VALUE mTagLibMPC= rb_define_module_under(mTagLib, "MPC");
    VALUE mTagLibMPEG = rb_define_module_under(mTagLib, "MPEG");
    VALUE mTagLibOgg = rb_define_module_under(mTagLib, "Ogg");
    VALUE mTagLibOggFlac = rb_define_module_under(mTagLibOgg, "Flac");
    VALUE mTagLibOggSpeex = rb_define_module_under(mTagLibOgg, "Speex");
    VALUE mTagLibVorbis = rb_define_module_under(mTagLib, "Vorbis");
    VALUE mTagLibTrueAudio = rb_define_module_under(mTagLib, "TrueAudio");
    VALUE mTagLibWavPack = rb_define_module_under(mTagLib, "WavPack");
%}

%define MAP_HELPERS(KEY_TYPE,VALUE_TYPE,FUNC_KEY,FUNC_VALUE) 
%extend Map<KEY_TYPE, VALUE_TYPE> {
    VALUE __getitem__(KEY_TYPE &item) {
        if($self->contains(item)) {
            VALUE_TYPE val=$self->operator[](item);
            return FUNC_VALUE(&val);
        } else {
            return Qnil;
        }
    }
    VALUE __hash__() {
        uint i;
        VALUE hash=rb_hash_new();
        for(std::map<KEY_TYPE,VALUE_TYPE>::const_iterator it=$self->begin(); it!=$self->end();it++) {
            VALUE key=FUNC_KEY(&it->first);
            VALUE ary=FUNC_VALUE(&it->second);
            rb_hash_aset(hash,key,ary);
        }
        return hash;
    }
}
%enddef

%define FILE_VIRTUALS()
virtual ~File();
virtual Tag * 	tag () const;
virtual Properties * 	audioProperties () const;
virtual bool 	save ();
%enddef

%define PROPERTIES_VIRTUALS()
virtual int 	length () const;
virtual int 	bitrate () const;
virtual int 	sampleRate () const;
virtual int 	channels () const;
%enddef

%define TAG_VIRTUALS()

%alias setTitle "title="
%alias setArtist "artist="
%alias setAlbum "album="
%alias setComment "comment="
%alias setGenre "genre="
%alias setYear "year="
%alias setTrack "track="
%alias isEmpty "empty?"

virtual ~Tag();
virtual String title() const;
virtual String artist() const;
virtual String album() const;
virtual String comment() const;
virtual String genre() const;
virtual uint year() const;
virtual uint track() ;
virtual void setTitle(const String & s);
virtual void setArtist(const String & s);
virtual void setAlbum(const String & s);
virtual void setComment(const String & s);
virtual void setGenre(const String & s);
virtual void setYear(uint i);
virtual void setTrack(uint i);
virtual bool isEmpty();
%enddef

%feature("autodoc",1);
namespace TagLib {

//rename(TagLib_File) File;


%typemap(in) TagLib::StringList & {
    TagLib::StringList *sl=new TagLib::StringList();
    for(long i=0;i<RARRAY_LEN($input);i++) {
        SafeStringValue(RARRAY_PTR($input)[i]);
        TagLib::String ntl=TagLib::String(StringValuePtr(RARRAY_PTR($input)[i]));
        sl->append(ntl);
    }
    $1=sl;
};



%typemap(out) TagLib::StringList {
    $result=StringList2Ruby(&$1);
}

%apply  TagLib::StringList & {TagLib::StringList const &};


%typemap(out) String {
    $result = String2Ruby(&$1);
};
/**
%typemap(in) String {
    $1=new TagLib::String(StringValuePtr($input), TagLib::String::UTF8);
};
*/

%apply String {String &, const String &};
%typemap(in) ByteVector {
    Check_Type($input, T_STRING);
    $1=new TagLib::ByteVector(StringValuePtr($input), RSTRING_LEN($input));
};


%typemap(out) ByteVector {
    $result = rb_tainted_str_new($1.data(),$1.size());
};

%apply ByteVector {ByteVector &, const ByteVector &, ByteVector const &};

%typemap(out) TagLib::ID3v2::FrameList {
    $result = FrameList2Ruby($1);
};

%apply TagLib::ID3v2::FrameList {TagLib::ID3v2::FrameList &, const TagLib::ID3v2::FrameList &, TagLib::ID3v2::FrameList const &};

class AudioProperties {
    AudioProperties(ReadStyle style);
    virtual ~AudioProperties();

    public:
    enum ReadStyle {
    Fast,Average,Accurate};
    PROPERTIES_VIRTUALS()
};
class String {
    public:
    enum  	Type {
    Latin1 = 0, UTF16 = 1, UTF16BE = 2, UTF8 = 3,
    UTF16LE = 4
    };
    
    String();
    String(const char *s, Type t=Latin1);
    ~String();
    const char* toCString();
    
    };
class Tag {
    protected:
    Tag();
    public:
    TAG_VIRTUALS()
};
class ByteVector {
    public:
    ByteVector(const char *data, uint length);
    ByteVector(const char *data);
    ~ByteVector();
    uint size();
    const char * 	data () const;
    %extend {
        const char * __str__() {
            return $self->data();
        }
    }
};

class File {
    protected:
    File(FileName file);

    void 	setValid (bool valid);
    void 	truncate (long length);
    public:
#ifdef SWIGRUBY 
    %alias readOnly "read_only?"
    %alias isWritable "writable?"
    %alias isOpen "open?"
    %alias isValid "valid?"
#endif
    enum  	Position { Beginning, Current, End  };
    FileName 	name() const;
    virtual 	~File ();
    virtual Tag * 	tag () const;
    virtual AudioProperties * 	audioProperties () const;
    virtual bool 	save ();
    ByteVector 	readBlock (ulong length);
    void 	writeBlock (const ByteVector &data);
   
   
    %rename(find3) find(const ByteVector &pattern, long fromOffset, const ByteVector &before);
    %rename(find2) find(const ByteVector &pattern, long fromOffset);
    %rename(find1) find(const ByteVector &pattern);

   long find(const ByteVector &pattern);
   long find(const ByteVector &pattern, long fromOffset = 0);
   long find(const ByteVector &pattern, long fromOffset=0, const ByteVector &before=ByteVector::null);

   long 	rfind (const ByteVector &pattern, long fromOffset=0, const ByteVector &before=ByteVector::null);
    void 	insert (const ByteVector &data, ulong start=0, ulong replace=0);
    void 	removeBlock (ulong start=0, ulong length=0);
    bool 	readOnly () const;
    bool 	isOpen () const;
    bool 	isValid () const;
    void 	seek (long offset, Position p=Beginning);
    void 	clear ();
    long 	tell () const;
    long 	length ();
    %extend {
        bool isWritable() {
            return !$self->readOnly();
        }
    }
};

    
    
    
    template<class T> class List {
        public:
         	List ();
            List (const List< T > &l);
            virtual 	~List ();
            uint 	size () const;
            bool 	isEmpty () const;
            bool 	contains (const T &value) const ;
    };
    
    
    
    
    
    template<class Key, class T> class Map {
        public:
        #ifdef SWIGRUBY 
        %alias isEmpty "empty?"
        #endif
        Map();
        template <class Key,class T> Map(const Map< Key, T > &m);
        ~Map();
        Map<Key,T>& insert( const Key&, const T &);
        Map<Key,T>& clear();
        uint size();
        %predicate Map::isEmpty();
        bool isEmpty();
        %predicate Map::contains();
        bool 	contains (const Key &key);
        %extend {
             uint __len__() {
                 return $self->size();
             }
        }
        
    };
    // Helpers for FieldListMap
    
    MAP_HELPERS(TagLib::String, TagLib::StringList, String2Ruby, StringList2Ruby)
    // Helpers for GenreMap
    MAP_HELPERS(TagLib::String, int, String2Ruby, INT2FIX)
    // Helpers for FrameListMap
    MAP_HELPERS(TagLib::ByteVector, TagLib::ID3v2::FrameList, ByteVector2Ruby, FrameList2Ruby)
    
    
    
    %template (FieldListMap) Map<TagLib::String, TagLib::StringList>;
    %template (ItemListMap) Map<TagLib::String, TagLib::APE::Item>;
    %template (GenreMap) Map<TagLib::String, int>;
    %template (FrameListMap) Map < TagLib::ByteVector, TagLib::ID3v2::FrameList >;

    %template (StringList) List< TagLib::String >; 
    %template (ByteVectorList) List<TagLib::ByteVector>;
    %template (FrameList) List< TagLib::ID3v2::Frame * >; 

    typedef List<TagLib::ByteVector> ByteVectorList;
    typedef List<TagLib::String> StringList;

    // Extends FrameListMap
    

    class FileRef {
        public:
        static StringList 	defaultFileExtensions ();
#ifdef SWIGRUBY 
        %alias isNull "null?"
#endif
        FileRef(FileName fileName, bool readAudioProperties = true,  	AudioProperties::ReadStyle   	 audioPropertiesStyle = AudioProperties::Average);
        ~FileRef();
        Tag* tag();
        AudioProperties* audioProperties();
        File* file();
        bool save();
        bool isNull();
        
    };
    
    
    namespace APE {
        typedef Map<TagLib::String,TagLib::APE::Item> ItemListMap;
            
        %rename(APE_Tag) Tag;
        %rename(APE_Item) Item;
        %rename(APE_Footer) Footer;
        
        class Footer {
            public:
            Footer ();
            Footer (const ByteVector &data);
            virtual 	~Footer ();
            uint 	version () const;
            bool 	headerPresent () const;
            bool 	footerPresent () const;
            bool 	isHeader () const;
            void 	setHeaderPresent (bool b) const;
            uint 	itemCount () const;
            void 	setItemCount (uint s);
            uint 	tagSize () const;
            uint 	completeTagSize () const;
            void 	setTagSize (uint s);
            void 	setData (const ByteVector &data);
            ByteVector 	renderFooter () const;
            ByteVector 	renderHeader () const ;
        };
        
        class Item {
            public:
            enum  	ItemTypes { Text = 0, Binary = 1, Locator = 2 };            
            Item ();
            Item (const String &key, const String &value);
            Item (const String &key, const StringList &values);
            Item (const Item &item);
            virtual 	~Item ();
            //Item & 	operator= (const Item &item);
            String 	key () const;
            ByteVector 	value () const;
            void 	setKey (const String &key);
            void 	setValue (const String &value);
            void 	setValues (const StringList &values);
            void 	appendValue (const String &value);
            void 	appendValues (const StringList &values);
            int 	size () const;
            String 	toString () const;
            StringList 	toStringList () const;
            StringList 	values () const;
            ByteVector 	render () const;
            void 	parse (const ByteVector &data);
            void 	setReadOnly (bool readOnly);
            bool 	isReadOnly () const;
            void 	setType (ItemTypes type);
            ItemTypes 	type () const;
            bool 	isEmpty () const;             
        };
        
        class Tag : public TagLib::Tag {
            public:
            Tag();
            Tag (File *file, long footerLocation);
            
            ByteVector render();
            TAG_VIRTUALS()
            Footer * 	footer () const;
            const ItemListMap & 	itemListMap () const;
            void 	removeItem (const String &key);
            void 	addValue (const String &key, const String &value, bool replace=true);
            void 	setItem (const String &key, const Item &item);


        };
    };

    
            
    namespace Ogg {
        
        typedef Map<TagLib::String,TagLib::StringList> FieldListMap;

        %rename(Ogg_XiphComment) XiphComment;
        %rename(Ogg_Page) Page;
        %rename(Ogg_PageHeader) PageHeader;
        %rename(Ogg_File) File;
            
        class PageHeader {
            public:
            PageHeader (TagLib::Ogg::File *file=0, long pageOffset=-1);
            virtual 	~PageHeader ();
            bool 	isValid () const;
            List< int > 	packetSizes () const;
            void 	setPacketSizes (const List< int > &sizes);
            bool 	firstPacketContinued () const;
            void 	setFirstPacketContinued (bool continued);
            bool 	lastPacketCompleted () const;
            void 	setLastPacketCompleted (bool completed);
            bool 	firstPageOfStream () const;
            void 	setFirstPageOfStream (bool first);
            bool 	lastPageOfStream () const;
            void 	setLastPageOfStream (bool last);
            long long 	absoluteGranularPosition () const;
            void 	setAbsoluteGranularPosition (long long agp);
            uint 	streamSerialNumber () const;
            void 	setStreamSerialNumber (uint n);
            int 	pageSequenceNumber () const;
            void 	setPageSequenceNumber (int sequenceNumber);
            int 	size () const;
            int 	dataSize () const;
            ByteVector 	render () const;
        };
        class Page {
            public:
                enum  	ContainsPacketFlags { DoesNotContainPacket = 0x0000, CompletePacket = 0x0001, BeginsWithPacket = 0x0002, EndsWithPacket = 0x0004 };
                enum  	PaginationStrategy { SinglePagePerGroup, Repaginate };
                Page (TagLib::Ogg::File *file, long pageOffset);
                virtual 	~Page ();
                long 	fileOffset () const;
                const PageHeader * 	header () const;
                int 	firstPacketIndex () const;
                void 	setFirstPacketIndex (int index);
                ContainsPacketFlags 	containsPacket (int index) const;
                uint 	packetCount () const;
                ByteVectorList 	packets () const;
                int 	size () const;
                ByteVector 	render () const;

        };
        class File : public TagLib::File {
            protected:
            File (FileName file);
            public:
            virtual 	~File ();
            ByteVector 	packet (uint i);
            void 	setPacket (uint i, const ByteVector &p);
            const PageHeader * 	firstPageHeader ();
            const PageHeader * 	lastPageHeader ();
            virtual bool 	save ();
        };
        class XiphComment : public TagLib::Tag{
        public:
         	XiphComment ();
            XiphComment (const ByteVector &data);
            TAG_VIRTUALS()
            uint 	fieldCount ();
            const FieldListMap & 	fieldListMap();
            String 	vendorID ();
            %ignore addField(const String &key, const String &value);
            void 	addField (const String &key, const String &value, bool replace=true);
            %ignore removeField(const String &key, const String &value);
            void removeField(const String &key);
            //void removeField(const String &key, const String &value);
            
            bool 	contains (const String &key);
            ByteVector 	render ();
            ByteVector 	render (bool addFramingBit);
        };
        namespace FLAC {
            %rename (Ogg_Flac_File) File;
            class File : public TagLib::Ogg::File {
                public:
                File (FileName file, bool readProperties=true, TagLib::AudioProperties::ReadStyle propertiesStyle=Properties::Average);
                virtual 	~File ();
                virtual XiphComment * 	tag () const;
                virtual TagLib::FLAC::Properties * 	audioProperties () const;
                virtual bool 	save ();
                long 	streamLength ();
            };
        };
        namespace Speex {
            %rename (Ogg_Speex_File) File;
            %rename (Ogg_Speex_Properties) Properties;
            class Properties : public TagLib::AudioProperties {
                public:
                 	Properties (TagLib::Ogg::Speex::File *file, ReadStyle style=Average);
                    PROPERTIES_VIRTUALS()
                    int 	speexVersion () const ;
            };
            class File : public TagLib::Ogg::File {
                public:
                File (FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
                virtual 	~File ();
                virtual Ogg::XiphComment * 	tag () const;
                virtual Properties * 	audioProperties () const;
                virtual bool 	save ();
            };
        };
       ;        
    }; // end namespace Ogg
 namespace Vorbis {
            %rename(Vorbis_File) File;
            %rename(Vorbis_Properties) Properties;
                class Properties : public TagLib::AudioProperties {
                    public:
                    Properties(TagLib::Vorbis::File *file, ReadStyle style=Average);
                    PROPERTIES_VIRTUALS()
                    int 	vorbisVersion () const;
                    int 	bitrateMaximum () const;
                    int 	bitrateNominal () const;
                    int 	bitrateMinimum () const; 
                };
            
            class File : public TagLib::Ogg::File {
                public:
                File(FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
                virtual 	~File ();
                virtual Ogg::XiphComment * 	tag () const;
                virtual Properties * 	audioProperties () const;
                virtual bool 	save ();
                };
        }    
 namespace ID3v1 {
     
     typedef Map<TagLib::String,int> 	GenreMap;
     %rename (ID3v1_genre) genre(int index);
     %rename (ID3v1_genreIndex) genreIndex(const String &name);
     %rename (ID3v1_genreList) genreList();
     %rename (ID3v1_genreMap) genreMap();

     String genre(int index);
     int genreIndex(const String &name);
     StringList genreList();
     GenreMap genreMap();
        %rename(ID3v1_Tag) Tag;
        class Tag : public TagLib::Tag {
            public:
            Tag();
            Tag(File *file, long tagOffset);            
            TAG_VIRTUALS()
            ByteVector render() const;
            
        };
    };
    namespace ID3v2 {
        %rename(ID3v2_AttachedPictureFrame) AttachedPictureFrame;
        %rename(ID3v2_Tag) Tag;
        %rename(ID3v2_Header) Header;
        %rename(ID3v2_Frame) Frame;
        %rename(ID3v2_CommentsFrame) CommentsFrame;
        %rename(ID3v2_FrameFactory) FrameFactory;
        %rename(ID3v2_GeneralEncapsulatedObjectFrame) GeneralEncapsulatedObjectFrame;
        typedef List< Frame * >FrameList;
        typedef Map < ByteVector, FrameList > 	FrameListMap;
       
        class Header {
            Header();
            
        };

        
        class Frame : public TagLib::ID3v2::Header {
            public: 
            virtual 	~Frame ();
            ByteVector 	frameID () const;
            uint 	size () const ;
            %extend {
                VALUE __str__() {
                    return rb_tainted_str_new2($self->toString().toCString(false));
                }
            };
            
        };
        
         class AttachedPictureFrame : public TagLib::ID3v2::Frame {
            public: 
            enum  	Type {
              Other = 0x00, FileIcon = 0x01, OtherFileIcon = 0x02, FrontCover = 0x03,
              BackCover = 0x04, LeafletPage = 0x05, Media = 0x06, LeadArtist = 0x07,
              Artist = 0x08, Conductor = 0x09, Band = 0x0A, Composer = 0x0B,
              Lyricist = 0x0C, RecordingLocation = 0x0D, DuringRecording = 0x0E, DuringPerformance = 0x0F,
              MovieScreenCapture = 0x10, ColouredFish = 0x11, Illustration = 0x12, BandLogo = 0x13,
              PublisherLogo = 0x14
            };
            AttachedPictureFrame ();
            //AttachedPictureFrame (const ByteVector &data);
            
            %extend {
             static AttachedPictureFrame *new2(const ByteVector &data) {
                 return new TagLib::ID3v2::AttachedPictureFrame(data);
                }
             }
            
            
            virtual 	~AttachedPictureFrame ();
            virtual String 	toString () const;
            String::Type 	textEncoding () const;
            void 	setTextEncoding (String::Type t);
            String 	mimeType () const;
            void 	setMimeType (const String &m);
            Type 	type () const;
            void 	setType (Type t);
            String 	description () const;
            void 	setDescription (const String &desc);
            ByteVector 	picture () const;
            void 	setPicture (const ByteVector &p);
        };
        
        class CommentsFrame : public TagLib::ID3v2::Frame {

            static CommentsFrame* TagLib::ID3v2::CommentsFrame::findByDescription  	(  	const Tag * tag, const String &  	d);
            public:             
            CommentsFrame (String::Type encoding=String::Latin1);
            //CommentsFrame (const ByteVector &data);
            
            virtual 	~CommentsFrame ();
            virtual String 	toString () const;
            ByteVector 	language () const;
            String 	description () const;
            String 	text () const;
            void 	setLanguage (const ByteVector &languageCode);
            void 	setDescription (const String &s);
            virtual void 	setText (const String &s);
            String::Type 	textEncoding () const;
            void 	setTextEncoding (String::Type encoding);
        };
        class GeneralEncapsulatedObjectFrame {
            GeneralEncapsulatedObjectFrame ();
            GeneralEncapsulatedObjectFrame (const ByteVector &data);
            virtual 	~GeneralEncapsulatedObjectFrame ();
            virtual String 	toString ();
            String::Type 	textEncoding ();
            void 	setTextEncoding (String::Type encoding);
            String 	mimeType ();
            void 	setMimeType (const String &type);
            String 	fileName ();
            void 	setFileName (const String &name);
            String 	description ();
            void 	setDescription (const String &desc);
            ByteVector 	object ();
            void 	setObject (const ByteVector &object);
        };
        class FrameFactory {
            FrameFactory();
            ~FrameFactory();
        };
        class Tag : public TagLib::Tag {
            public:
            Tag();
            Tag(File *file, long tagOffset, const FrameFactory* factory);            
            TAG_VIRTUALS()
            Header *header();
            %apply SWIGTYPE *DISOWN {Frame *frame};
                void 	addFrame (Frame *frame);
            %clear Frame *frame;

            const FrameListMap& frameListMap() const;
            const FrameList& frameList() const;
            void removeFrame(Frame * frame, bool del = true); 	
            
            
        };
    };
    
    namespace FLAC {
        %rename(FLAC_Properties) Properties;
        %rename(FLAC_File) File;
        class Properties : public TagLib::AudioProperties {
            public: 
            //Properties(TagLib::ByteVector  data, long streamLength, TagLib::AudioProperties::ReadStyle style=Average);
            Properties(TagLib::FLAC::File * file, ReadStyle style = Average);
            virtual ~Properties();
            PROPERTIES_VIRTUALS()
            int sampleWidth();
        };
        %feature("docstring","/*\n  Document-class: TagLib::FLAC::File < TagLib::File\n*/\n") File;
        class File : public TagLib::File {
            public:
            File(FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            File(FileName file, ID3v2::FrameFactory *frameFactory, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            FILE_VIRTUALS()
            ID3v2::Tag * 	ID3v2Tag (bool create=false);
            ID3v1::Tag * 	ID3v1Tag (bool create=false);
            Ogg::XiphComment * 	xiphComment (bool create=false);
            void 	setID3v2FrameFactory (const ID3v2::FrameFactory *factory);
            ByteVector 	streamInfoData ();
            long 	streamLength ();
            
        };
        
    };

    
        namespace MPC {
        %rename(MPC_File) File;
        %rename(MPC_Properties) Properties;
        class Properties : public TagLib::AudioProperties {
            public:
            Properties(const ByteVector &data, long streamLength, ReadStyle style=Average);
            PROPERTIES_VIRTUALS()
            int mpcVersion() const;
        };
        
        class File : public TagLib::File {
            public:
            
            enum  	TagTypes {
                NoTags = 0x0000, ID3v1 = 0x0001, ID3v2 = 0x0002, APE = 0x0004, AllTags = 0xffff
            };
            
            
            
            File (FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            FILE_VIRTUALS()
            ID3v1::Tag * 	ID3v1Tag (bool create=false);
            APE::Tag * 	APETag (bool create=false);
            void 	strip (int tags=AllTags);
            void 	remove (int tags=AllTags);
        };
    };
    
    namespace TrueAudio {
        %rename(TrueAudio_File) File;
        %rename(TrueAudio_Properties) Properties;
        class Properties : public TagLib::AudioProperties {
            public:
            Properties(const ByteVector &data, long streamLength, ReadStyle style=Average);
            PROPERTIES_VIRTUALS()
           int 	bitsPerSample () const;
           int 	ttaVersion () const;
        };
        
        class File : public TagLib::File {
            public:
            enum  	TagTypes { NoTags = 0x0000, ID3v1 = 0x0001, ID3v2 = 0x0002, AllTags = 0xffff };
            File (FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            File (FileName file, ID3v2::FrameFactory *frameFactory, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            FILE_VIRTUALS()
            void 	setID3v2FrameFactory (const ID3v2::FrameFactory *factory);
            ID3v1::Tag * 	ID3v1Tag (bool create=false);
ID3v2::Tag * 	ID3v2Tag (bool create=false);
void 	strip (int tags=AllTags);
        };
    };
    
    namespace WavPack {
        %rename(WavPack_File) File;
        %rename(WavPack_Properties) Properties;
        class Properties : public TagLib::AudioProperties {
            public:
            Properties(const ByteVector &data, long streamLength, ReadStyle style=Average);
            PROPERTIES_VIRTUALS()
           int 	bitsPerSample () const;
           int 	version () const;
        };
        
        class File : public TagLib::File {
            public:
            enum  	TagTypes { NoTags = 0x0000, ID3v1 = 0x0001, APE = 0x0002, AllTags = 0xffff };
            File (FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            FILE_VIRTUALS()

            ID3v1::Tag * 	ID3v1Tag (bool create=false);
            APE::Tag * 	APETag (bool create=false);
            void 	strip (int tags=AllTags);
        };
    };
    
    namespace MPEG {
        %rename(MPEG_File) File;
        %rename(MPEG_Properties) Properties;
        %rename(MPEG_Header) Header;
        %rename(MPEG_XingHeader) XingHeader;
        class Header {
            public:
            enum  	Version { Version1 = 0, Version2 = 1, Version2_5 = 2 };
            enum  	ChannelMode { Stereo = 0, JointStereo = 1, DualChannel = 2, SingleChannel = 3 };
            Header(const ByteVector &data);
            Header(const Header &h);
            virtual 	~Header ();
            bool 	isValid () const;
            Version 	version () const;
            int 	layer () const;
            bool 	protectionEnabled () const;
            int 	bitrate () const;
            int 	sampleRate () const;
            bool 	isPadded() const;
            ChannelMode 	channelMode () const;
            bool 	isCopyrighted () const;
            bool 	isOriginal () const;
            int 	frameLength () const;
            int 	samplesPerFrame () const;
//            Header & 	operator= (const Header &h);
        };
        class XingHeader {
            public:
            XingHeader (const ByteVector &data);
            virtual 	~XingHeader ();
            bool 	isValid () const;
            uint 	totalFrames () const;
            uint 	totalSize () const;          
        };
        class Properties : public TagLib::AudioProperties {
            public:
            Properties(TagLib::MPEG::File *file, ReadStyle style=Average);
            PROPERTIES_VIRTUALS()
            const XingHeader * 	xingHeader () const;
            Header::Version 	version () const;
            int 	layer () const;
            bool 	protectionEnabled () const;
            Header::ChannelMode 	channelMode () const;
            bool 	isCopyrighted () const;
            bool 	isOriginal () const ;
        };        
        class File : public TagLib::File {
            public:
            enum  	TagTypes {
            NoTags = 0x0000, ID3v1 = 0x0001, ID3v2 = 0x0002, APE = 0x0004,
            AllTags = 0xffff};
            File (FileName file, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            File (FileName file, ID3v2::FrameFactory *frameFactory, bool readProperties=true, Properties::ReadStyle propertiesStyle=Properties::Average);
            FILE_VIRTUALS();
            bool 	save (int tags);
            bool 	save (int tags, bool stripOthers);
            ID3v2::Tag * 	ID3v2Tag (bool create=false);
            ID3v1::Tag * 	ID3v1Tag (bool create=false);
            APE::Tag * 	APETag (bool create=false);
            bool 	strip (int tags=AllTags);
            bool 	strip (int tags, bool freeMemory);
            void 	setID3v2FrameFactory (const ID3v2::FrameFactory *factory);
            long 	firstFrameOffset ();
            long 	nextFrameOffset (long position);
            long 	previousFrameOffset (long position);
            long 	lastFrameOffset ();;
        };
    };

};




     

