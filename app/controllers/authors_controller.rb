# encoding: utf-8
class AuthorsController < ApplicationController
  def login
    require 'digest/sha2'
    @title = "Login"
    
    if params[:commit] == "Login" and params[:login] then
      @author = Author.find_by_name params[:login][:name].downcase
      
      if @author then 
        @h_pw = Digest::SHA2.hexdigest(Digest::SHA2.hexdigest(params[:login][:password])+"äöüß"+@author.salt)
        @h_pw_orig = @author.password
        @salt = @author.salt
        @pw_clear = params[:login][:password]
        if @h_pw == @author.password then
          session[:login] = "jap"
          session[:au_id] = @author.id
          redirect_to "/"
        end
      end
      
    end
    
  end
  
  def logout
    session.clear
    redirect_to "/" and return
  end
  
  def add
    @title = "Hinzufügen"
    @errors = ""
    if params[:commit] then
      if params[:commit] == "Abbrechen" then
        redirect_to "/" and return
      end
    end
    
    if session[:login] == "jap" then
      if params[:author] then
        if params[:author][:password] != params[:author][:password_confirmation] then
          @errors += "|Passwörter stimmen nicht überein| "
          #redirect_to :action=> "add" and return
        else
          require 'digest/sha2'
         
          salt = Digest::SHA2.hexdigest(Time.now.to_s)
          pw = Digest::SHA2.hexdigest(params[:author][:password])
          h_pw = Digest::SHA2.hexdigest(pw+"äöüß"+salt)                    
          attr = {:name => params[:author][:name],:password => h_pw,:salt => salt}
          @author = Author.new(attr)
          
          if @author.save then
            redirect_to "/"
          else
            @errors += "|Name schon vorhanden|"
          end
            
        end                
      end
    else
      redirect_to "/login" and return
    end
    
  end
  
  def del
    
  end
  
end