#include <ruby.h>
#include <taglib/tag_c.h>
#define GET_TL_TAG(self,tag) \
taglib_t *tl; \
TagLib_Tag *tag; \
Data_Get_Struct(self, taglib_t, tl); \
if(NULL==tl->file || tl->open==0) {tl_closed();} \
tag=tl->tag;

#define GET_TL_CHECK(self,file) \
taglib_t *tl; \
TagLib_File *file; \
Data_Get_Struct(self, taglib_t, tl); \
if(NULL==tl->file || tl->open==0) {tl_closed();} \
file=tl->file;


typedef struct {
    TagLib_File    *file;
    TagLib_Tag     *tag;
    const TagLib_AudioProperties *audio;
    int             open;
} taglib_t;

void
tl_closed()
{
    rb_raise(rb_eException, "FileTag already closed");
}

static void
_tag_lib_file_free(taglib_t * t)
{
    taglib_file_free(t->file);
    free(t);
}


VALUE           mTagFile;
VALUE           cTagFileFile;
VALUE           eBadPath;
VALUE           eBadFile;
VALUE           eBadTag;
VALUE           eBadAudioProperties;

VALUE           cTagFileFile_new(int argc, VALUE * argv, VALUE class);
VALUE           cTagFileFile_close(VALUE self);
VALUE           cTagFileFile_save(VALUE self);
VALUE           cTagFileFile_init(VALUE self, VALUE path, VALUE file_type);
VALUE           cTagFileFile_title(VALUE self);
VALUE           cTagFileFile_artist(VALUE self);
VALUE           cTagFileFile_album(VALUE self);
VALUE           cTagFileFile_comment(VALUE self);
VALUE           cTagFileFile_genre(VALUE self);
VALUE           cTagFileFile_year(VALUE self);
VALUE           cTagFileFile_track(VALUE self);

VALUE           cTagFileFile_title_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_artist_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_album_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_comment_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_genre_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_year_set(VALUE self, VALUE valor);
VALUE           cTagFileFile_track_set(VALUE self, VALUE valor);

VALUE           cTagFileFile_length(VALUE self);
VALUE           cTagFileFile_bitrate(VALUE self);
VALUE           cTagFileFile_samplerate(VALUE self);
VALUE           cTagFileFile_channels(VALUE self);

/**
* module TagLib
* 
* Defines TagLib::File as class
*/

void
Init_tagfile()
{
    mTagFile = rb_define_module("TagFile");
    cTagFileFile = rb_define_class_under(mTagFile, "File", rb_cObject);
    eBadPath = rb_define_class_under(mTagFile, "BadPath", rb_eIOError);
    eBadFile = rb_define_class_under(mTagFile, "BadFile", rb_eException);
    eBadTag = rb_define_class_under(mTagFile, "BadTag", rb_eException);
    eBadAudioProperties =
	rb_define_class_under(mTagFile, "BadAudioProperties",
			      rb_eException);
    rb_define_singleton_method(cTagFileFile, "new", cTagFileFile_new, -1);
    rb_define_method(cTagFileFile, "initialize", cTagFileFile_init, 2);
    rb_define_method(cTagFileFile, "save", cTagFileFile_save, 0);
    rb_define_method(cTagFileFile, "close", cTagFileFile_close, 0);

    rb_define_method(cTagFileFile,"title", cTagFileFile_title, 0);
    rb_define_method(cTagFileFile,	"title=", cTagFileFile_title_set, 1);
    rb_define_method(cTagFileFile,	"artist", cTagFileFile_artist, 0);
    rb_define_method(cTagFileFile,	"artist=", cTagFileFile_artist_set, 1);
    rb_define_method(cTagFileFile,	"album", cTagFileFile_album, 0);
    rb_define_method(cTagFileFile,	"album=", cTagFileFile_album_set, 1);
    rb_define_method(cTagFileFile,	"comment", cTagFileFile_comment, 0);
    rb_define_method(cTagFileFile,	"comment=", cTagFileFile_comment_set, 1);
    rb_define_method(cTagFileFile,	"genre", cTagFileFile_genre, 0);
    rb_define_method(cTagFileFile,	"genre=", cTagFileFile_genre_set, 1);
    rb_define_method(cTagFileFile,	"track", cTagFileFile_track, 0);
    rb_define_method(cTagFileFile,	"track=", cTagFileFile_track_set, 1);
    rb_define_method(cTagFileFile,	"year", cTagFileFile_year, 0);
    rb_define_method(cTagFileFile,	"year=", cTagFileFile_year_set, 1);
    rb_define_method(cTagFileFile,	"length", cTagFileFile_length, 0);
    rb_define_method(cTagFileFile,	"bitrate", cTagFileFile_bitrate, 0);
    rb_define_method(cTagFileFile,	"samplerate", cTagFileFile_samplerate, 0);
    rb_define_method(cTagFileFile,	"channels", cTagFileFile_channels, 0);
    rb_define_attr(cTagFileFile, "path", 1, 0);
    rb_define_attr(cTagFileFile, "file_type", 1, 0);
	/* TagLib_File_OggVorbis: Value for OggVorbis*/
	
    rb_define_const(mTagFile, "MPEG", INT2FIX(TagLib_File_MPEG));
    rb_define_const(mTagFile, "OggVorbis", INT2FIX(TagLib_File_OggVorbis));
    rb_define_const(mTagFile, "FLAC", INT2FIX(TagLib_File_FLAC));
    rb_define_const(mTagFile, "MPC", INT2FIX(TagLib_File_MPC));
}
/*
* Tagfile::File.new ( path, file_type=nil) -> Tagfile::File
* call-seq:
* - Tagfile::File.new('music.mp3')
* - Tagfile::File.new('music.mp3', Tagfile::MPEG)
*
* If seconf 
*/
VALUE
cTagFileFile_new(int argc, VALUE * argv, VALUE class)
{
    TagLib_File    *tlf;
    VALUE           path;
    VALUE           file_type;
	VALUE           c_argv[2];
	VALUE tdata;
     char           *cpath;
    rb_scan_args(argc, argv, "11", &path, &file_type);
    Check_Type(path, T_STRING);
    SafeStringValue(path);
    cpath = StringValuePtr(path);
    if (file_type != Qnil) {
        FIXNUM_P(file_type);
        tlf = taglib_file_new_type(cpath, FIX2INT(file_type));
    } else {
        tlf = taglib_file_new(cpath);
    }
    if (NULL == tlf) {
	rb_raise(eBadFile, "Bad file");
	return Qnil;
    } else {
	taglib_t       *tl = ALLOC(taglib_t);
	tl->file = tlf;
	tl->tag = taglib_file_tag(tlf);
	tl->open = 1;
	if (NULL == tl->tag) {
	    rb_raise(eBadTag, "Bad Tag");
	}
	tl->audio = taglib_file_audioproperties(tlf);
	if (NULL == tl->tag) {
	    rb_raise(eBadAudioProperties, "Bad Audio");
	}
	tdata =
	    Data_Wrap_Struct(class, 0, _tag_lib_file_free, tl);
	c_argv[0] = path;
	c_argv[1] = file_type;
	rb_obj_call_init(tdata, 2, c_argv);
	return tdata;
    }
}

VALUE
cTagFileFile_init(VALUE self, VALUE path, VALUE file_type)
{
    Check_Type(path, T_STRING);
    rb_iv_set(self, "@path", path);
    rb_iv_set(self, "@file_type", file_type);
    return self;
}
/*
* Save tags to file
*/

VALUE
cTagFileFile_save(VALUE self)
{
    GET_TL_CHECK(self, file);
    return (taglib_file_save(file) ? Qtrue : Qfalse);
}
VALUE
cTagFileFile_close(VALUE self)
{
    taglib_t       *tl;
    Data_Get_Struct(self, taglib_t, tl);
    tl->open = 0;
    // taglib_file_free(tl->file);
    rb_iv_set(self, "@path", Qnil);
    rb_iv_set(self, "@file_type", Qnil);
    
    return Qtrue;
}
VALUE
_get_string(VALUE self, char *(*func) ())
{
    VALUE           string;
    char           *cstring;
    GET_TL_TAG(self, tag);
    cstring = func(tag);
    string = rb_str_new2(cstring);
    taglib_tag_free_strings();
    return string;
}

VALUE 
_get_uint(VALUE self, unsigned int (*func) ())
{
    GET_TL_TAG(self, tag);
    return INT2FIX(func(tag));
}

VALUE
_get_audio_int(VALUE self, int (*func) ())
{
    taglib_t       *tl;
    Data_Get_Struct(self, taglib_t, tl);
    if (NULL == tl->file) {
	return Qnil;
    } else {
	return INT2FIX(func(tl->audio));
    }
}


VALUE
_set_string(VALUE self, void (*func) (TagLib_Tag *, const char *),
	    VALUE texto)
{
    taglib_t       *tl;
    Data_Get_Struct(self, taglib_t, tl);
    if (NULL == tl) {
	return Qnil;
    } else {
	// StringValue trys to get a string value from the argument. This argument
	// doesn't need to be a string, just behave like one (=> respond to :to_str)
	// else a TypeError is thrown
	func(tl->tag, StringValuePtr(texto));
	return Qtrue;
    }
}

VALUE
_set_uint(VALUE self, void (*func) (TagLib_Tag *, unsigned int),
	  VALUE numero)
{
    taglib_t       *tl;
    Data_Get_Struct(self, taglib_t, tl);
    if (NULL == tl) {
	return Qnil;
    } else {
	// NUM2INT trys to get an integer value from the argument. This argument
	// doesn't need to be a Fixnum, just behave like one (=> respond to :to_int)
	// else a TypeError is thrown
	func(tl->tag, NUM2INT(numero));
	return Qtrue;
    }
}

/*
 * Document-method: title
 *
 * Get title
 * call-seq:
 *  tagfile.title
 */

VALUE
cTagFileFile_title(VALUE self)
{
    return _get_string(self, taglib_tag_title);
}

/*
* Get  artist name
*/


VALUE
cTagFileFile_artist(VALUE self)
{
    return _get_string(self, taglib_tag_artist);
}

/*
* Get album name
*/

VALUE
cTagFileFile_album(VALUE self)
{
    return _get_string(self, taglib_tag_album);
}

/*
* Get comment
*/


VALUE
cTagFileFile_comment(VALUE self)
{
    return _get_string(self, taglib_tag_comment);
}

/*
* Get genre
*/


VALUE
cTagFileFile_genre(VALUE self)
{
    return _get_string(self, taglib_tag_genre);
}

/*
* Get year
*/


VALUE
cTagFileFile_year(VALUE self)
{
    return _get_uint(self, taglib_tag_year);
}

/*
* Get track number
*/


VALUE
cTagFileFile_track(VALUE self)
{
    return _get_uint(self, taglib_tag_track);
}

VALUE
cTagFileFile_title_set(VALUE self, VALUE valor)
{
    return _set_string(self, taglib_tag_set_title, valor);
}

VALUE
cTagFileFile_artist_set(VALUE self, VALUE valor)
{
    return _set_string(self, taglib_tag_set_artist, valor);
}

VALUE
cTagFileFile_album_set(VALUE self, VALUE valor)
{
    return _set_string(self, taglib_tag_set_album, valor);
}
VALUE
cTagFileFile_comment_set(VALUE self, VALUE valor)
{
    return _set_string(self, taglib_tag_set_comment, valor);
}
VALUE
cTagFileFile_genre_set(VALUE self, VALUE valor)
{
    return _set_string(self, taglib_tag_set_genre, valor);
}

VALUE
cTagFileFile_year_set(VALUE self, VALUE valor)
{
    return _set_uint(self, taglib_tag_set_year, valor);
}
VALUE
cTagFileFile_track_set(VALUE self, VALUE valor)
{
    return _set_uint(self, taglib_tag_set_track, valor);
}

VALUE
cTagFileFile_length(VALUE self)
{
    return _get_audio_int(self, taglib_audioproperties_length);
}

VALUE
cTagFileFile_bitrate(VALUE self)
{
    return _get_audio_int(self, taglib_audioproperties_bitrate);
}
VALUE
cTagFileFile_samplerate(VALUE self)
{
    return _get_audio_int(self, taglib_audioproperties_samplerate);
}
VALUE
cTagFileFile_channels(VALUE self)
{
    return _get_audio_int(self, taglib_audioproperties_channels);
}

