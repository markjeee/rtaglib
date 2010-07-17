#!/usr/bin/ruby
#### Make docs
require '../lib/rtaglib_mswin32'

require 'rexml/document'
require 'TagLib'
require 'rbconfig'

def data_method(fm)
if !fm.nil?
    brief_desc=fm[:brief_desc].gsub(/\s+/im,"").size>0 ? "<b>#{fm[:brief_desc]}</b>\n":""
    desc=(" # "+brief_desc+fm[:long_desc]+"\n").gsub("\n","\n # ")+"\n"
    params=fm[:param].join(",")
    #p params
else
    desc=""
    params=""
end
{:desc=>desc,:params=>params}
end

def print_methods(klass,functions,indent)
    out=""
    methods=klass.singleton_methods-Object.singleton_methods
    #p functions
    if(methods.size>0)
    out << indent+"# Singleton methods\n"
    methods.each{|m|
        dm=data_method(functions[m])
        out << dm[:desc]+indent+"def self.#{m}(#{dm[:params]})\n"+indent+"end\n"
    }
    end
    methods=klass.instance_methods-Object.instance_methods
    methods.each{|m|
        dm=data_method(functions[m])
        out << dm[:desc]+indent+"def #{m}(#{dm[:params]})\n"+indent+"end\n"
    }
    out
end
def get_doxygen_description(xml_file)
    out=""
    funcs={}
    if(File.exists? xml_file)
        #p xml_file
        xml=REXML::Document.new(File.new(xml_file))
        short_desc=xml.root.elements["/doxygen/compounddef/briefdescription"].to_s.gsub(/<.+?>/,"")
        long_desc=xml.root.elements["/doxygen/compounddef/detaileddescription"].to_s.gsub(/<.+?>/,"")
        out+=" # "+("<b>"+short_desc+".</b>\n\n"+long_desc).gsub("\n","\n # ")
        out+="\n # \n"
        # functions
        xml.elements.each("/doxygen/compounddef/sectiondef[@kind='public-func']/memberdef[@kind='function']") {|func|
            name=func.elements["name"].text
            brief=func.elements["briefdescription"].to_s.gsub(/<.+?>/,"")
            long=func.elements["detaileddescription"].to_s.gsub(/<.+?>/,"")
            
            param=[]
            func.elements.each("param") {|xpar|
                if xpar.elements["defval"]
                    param.push(xpar.elements["declname"].text+" = "+xpar.elements["defval"].to_s.gsub(/<.+?>/,""))
                else
                    param.push(xpar.elements["declname"].text)
                end
            }
            funcs[name]={:param=>param,:brief_desc=>brief,:long_desc=>long}
        }
    else
	    puts "Can't find #{xml_file}"
    end
    {:object=>out,:functions=>funcs}
end
def name_xml_file(klass)
	klass_name=klass.to_s.gsub(":","_1")
	if(Config::CONFIG['host']=~/mingw/i)
#	klass_name.gsub!(/[A-Z]/) {|t| "_"+t.downcase}
	end
	klass_name
end
def print_class(klass,indent)
    out=""
    xml_file=BASE_DOCS+"/xml/class"+name_xml_file(klass)+".xml"
    dd=get_doxygen_description(xml_file)
    out+=dd[:object]
    #p dd[:functions]
    if klass.superclass != Object
    out+=indent+"class #{klass} < "+klass.superclass.to_s+"\n"
    else
        out+=indent+"class #{klass}\n"
    end
    out+=print_methods(klass,dd[:functions],indent+"  ")
    out << indent+"end\n"
end
def print_module(mod,indent)
    out=""
    xml_file=BASE_DOCS+"/xml/namespace"+name_xml_file(mod)+".xml"
    dd=get_doxygen_description(xml_file)
    out+=dd[:object]
    out+=indent+"module #{mod}\n"
    out+=indent+print_methods(mod,dd[:functions],indent+"  ")
    submods=[]
    mod.constants.each {|c|
        if mod.const_get(c).class==Module
            submods.push(c)
        else
            out << print_constant(mod,c,indent+"  ")
        end
    }
    submods.each{|sm|
        out << print_constant(mod,sm,indent+"  ")
    }
    out << indent+"end\n"
    out
end
def print_constant(obj,con,indent)
    out=""
    if(obj.const_get(con).class==Module)
    out+=print_module(obj.const_get(con),indent+"  ")
    elsif(obj.const_get(con).class==Class)
        out+=print_class(obj.const_get(con),indent)
    else
        out+=indent+"#{con}="+obj.const_get(con).to_s+"\n"
    end
    out
end

BASE_DOCS="doxygen"
File.open("TagLib_doc.rb","wb") {|fo|
	df=Object.methods
	out=""
	out=print_constant(ObjectSpace,"TagLib","")
	fo.puts out
}
