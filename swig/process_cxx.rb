#!/usr/bin/ruby
require 'fileutils'
file="pre_taglib_#{PLATFORM}"
out="taglib_#{PLATFORM}.cxx"
fo=File.open(out,"wb")
swig_p={}
File.open(file,"r") {|f| f.each_line {|l|
        l.gsub!("SWIGINTERN VALUE","VALUE")
        if(l=~/SWIG_TypeClientData\((.+),\s*\(void \*\) &(.+)\);/)
            swig_p[$1]=$2
        end
        if(l=~/\s+(.+) = rb_define_class_under\(mTagLib, "(.+)",\s*(.+swig_class.+ (.+?)\->.+|\s+rb_cObject\));/)
            clase=$1
            final=$3
            clase_padre=$4
            ruta=$2.split("_")
            if(ruta.size>1)
                mod="mTagLib"+ruta[0,ruta.size-1].join
                clas=ruta[ruta.size-1]
                if clase_padre.nil?
                    linea=sprintf("%s = rb_define_class_under(%s, \"%s\", rb_cObject);",clase,mod,clas)
                else
                    linea=<<HERE
#{clase} = rb_define_class_under(#{mod}, "#{clas}", ((swig_class *) #{clase_padre}->clientdata)->klass);
HERE
                end
                #p linea
                fo.puts(linea)
            else
                fo.puts l
            end
        elsif l=~/\s+rb_define_module_function\((.+?), "(.+?)", VALUEFUNC\((.+)\), -1\);/
            bass_mod=$1
            method=$2
            c_func=$3
            path=method.split("_")
            if(path.size>1)
                mod="mTagLib"+path[0,path.size-1].join
                new_method=path[path.size-1]
                fo.puts("rb_define_module_function(#{mod},\"#{new_method}\", VALUEFUNC(#{c_func}),-1);\n");
            else
                fo.puts l
            end
        else
            fo.puts l
        end
    }
}
fo.close
