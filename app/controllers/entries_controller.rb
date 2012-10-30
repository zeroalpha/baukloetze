# encoding: utf-8
class EntriesController < ApplicationController
  helper_method :parse_html_to_text,:parse_text_to_html#Damit die 2 funktionen auch in den views zur verfügung stehen
  def add
    @title = " | Hinzufügen"
    
    if session[:login] == "jap" then
      if params[:entry] then
        /\A\<p\>(.*)\<\/p\>\z/m =~ params[:entry][:content]
        attr = {:title => params[:entry][:title], :content => $1,:author_id => session[:au_id]}#{:title => params[:entry][:title],:content=> params[:entry][:content]}
      else
        attr = {}
      end
      @entry = Entry.new(attr)
      if @entry.save then
        redirect_to :action => "read", :id=> @entry.id
      end
    else
      redirect_to "/login" and return
    end
  end

  def read
    @title = " | Lesen"
    @entries = []
    
    if params[:id] then

      @entry = Entry.find params[:id]
    else
      @entries = Entry.last(5).reverse
    end
  end

  def rem
    @title = " | Löschen"
    
    if session[:login]=="jap" then
  
      if params[:id] then
        @e_id = params[:id]
      elsif params[:entry] then
        @e_id = params[:entry][:id]
      elsif params[:magic] then
        @e_id = params[:magic]
      end
      
      if params[:commit] == "Nein" then
        redirect_to :action => "read",:id => @e_id
      elsif @e_id.nil? then
        @select = true
        @e_sel = Entry.all.reverse
        @text = "Wählen sie einen Beitrag aus"
#      elsif params[:commit] == "Wählen" then
      elsif @e_id and params[:commit] == "Ja" then
        @entry = Entry.find @e_id
        @entry.destroy
        redirect_to "/"
      elsif @e_id then
        @entry = Entry.find @e_id
        @title = @title + " : (#{@entry.id}) #{@entry.title}"
        @text = "Wollen sie den Eintrag (#{@entry.id}) #{@entry.title} wirklich löschen ?"
        @magic_id = @e_id
      end
    else
      redirect_to "/login" and return
    end
  end

  def edit
    @title = " | Ändern"
    
    if session[:login]=="jap" then
    

      
      if params[:id] then
        @e_id = params[:id]
      elsif params[:entry] then
        @e_id = params[:entry][:id]
      elsif params[:magic] then
        @e_id = params[:magic]
      end
      
      if params[:commit] == "Abbrechen" then
        redirect_to :action => "read" and return
      end
      
      if @e_id and params[:magic] and params[:commit] == "Ändern" then
        @entry = Entry.find @e_id
        /\A\<p\>(.*)\<\/p\>\z/m =~ params[:content]
        @entry.content = $1
        @entry.title = params[:title]
        @entry.save
        redirect_to :action => "read",:id => @e_id and return
      elsif @e_id then
        @select = false
        @entry = Entry.find @e_id
        @rows = @entry.content.scan(/\n/).size/1.7
        @rows = @rows.to_i
      else
        @select = true
        @e_sel = Entry.all.reverse
        @text = "Wählen sie einen Beitrag aus"
      end
    else
      redirect_to "/login" and return
    end
    
    
  end
  
#  private
  def parse_html_to_text(text)#HTML sonderzeichen durch lesbare ersetzen
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
    text
  end
  def parse_text_to_html(text)#HTML sonderzeichen kodieren
    text.gsub!("ä","&auml;")
    text.gsub!("Ä","&Auml;")
    text.gsub!("ö","&ouml;")
    text.gsub!("Ö","&Ouml;")
    text.gsub!("ü","&uuml;")
    text.gsub!("Ü","&Uuml;")
    text.gsub!("ß","&szlig;")
    text.gsub!("<","&lt;")
    text.gsub!(">","&gt;")
    text.gsub!(" ","&nbsp;")
    text.gsub!("\"","&quot;")
    text.gsub!("\'","&x27;")
    text.gsub!("\n","<br />")
    text
  end
  
end
