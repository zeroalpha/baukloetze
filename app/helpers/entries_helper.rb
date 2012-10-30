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
      
      sym = case m[0]
      when "ruby"
        :ruby
      when "erb"
        :erb
      end        
      
      code_html = CodeRay.scan(m[1],sym).div(:line_numbers => :inline)
      text.gsub!("${CODE_#{m[0]}}" + m[1] + "${!CODE_#{m[0]}}",code_html)
    end
    return text
  end
  
  def strip_p_tag(text)
    /\<p\>(.*)\<\/p\>/m =~ text
    text = $1
  end  
end
