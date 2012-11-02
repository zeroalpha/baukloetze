# encoding: utf-8
module EntriesHelper
  
  def parse_text_with_code(text)
    require 'coderay'
    
    #text.count "${CODE}" zählt ALLE zeichen einzeln, alle $, alle {, alle C, alle O, usw}
    
    #anz_s = text.scan("${CODE}").size
    #anz_e = text.scan("${!CODE}").size
    
    #rx = /\$\{CODE\}(.*?)\$\{\!CODE\}/m
    rx = /\$\{CODE\_([a-z]+)\}(.*?)\$\{\!CODE\_[a-z]+\}/m
    mm = text.scan(rx)
    
    mm.each do |m|
      
      sym = m[0].to_sym
#      logger.debug 'Full : ' + text
#      logger.debug 'Before : ' + m[1]
#      tt = parse_html_to_text(m[1])
#      logger.debug 'After : ' + tt
      code_html = CodeRay.scan(parse_html_to_text(m[1]),sym).div(:line_numbers => :inline)
#      logger.debug 'CR : ' + code_html
      text.gsub!("${CODE_#{m[0]}}" + m[1] + "${!CODE_#{m[0]}}",code_html)
#      logger.debug 'pattern = ' + "${CODE_#{m[0]}}" + m[1] + "${!CODE_#{m[0]}}"
#      logger.debug 'Final : ' + text
    end
    return text
  end
  
  def strip_p_tag(text)  #DEPLOY wird nicht benutzt ?
    /\<p\>(.*)\<\/p\>/m =~ text
    text = $1
    text
  end
  def parse_html_to_text(text_in)#HTML sonderzeichen durch lesbare ersetzen
    text = text_in.dup
    text.gsub!(/<br[\s\/]*>/,"\n")
    text.gsub!("&quot;","\"")
    text.gsub!("&x27;","\'")
    text.gsub!("&auml;","ä")
    text.gsub!("&Auml;","Ä")
    text.gsub!("&ouml;","ö")
    text.gsub!("&Ouml;","Ö")
    text.gsub!("&uuml;","ü")
    text.gsub!("&Uuml;","Ü")
    text.gsub!("&szlig;","ß")
    text.gsub!("&lt;","<")
    text.gsub!("&gt;",">")
    text.gsub!("&nbsp;"," ")
    
    text.gsub!("<p>","")
    text.gsub!("</p>","\n")

    text.chomp!
    while text[0] == "\n" do #alle führenden leerzeilen töten
      text.slice!(0,1)
    end        
    text
  end
  
  def clean_entry_text(entry_text)
    text = entry_text.dup
    text.gsub!(/<p><\/p>\z/,"")
    text.chomp!    
  end
end
