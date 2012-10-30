# encoding: utf-8
class AuthorsController < ApplicationController
  @secret = "<---Sekret--->"
   require 'digest/sha2'
  def login
    require 'digest/sha2'
    @title = "Login"
    
    if params[:commit] == "Login" and params[:login] then
      @author = Author.find_by_name params[:login][:name].downcase
      
      if @author then           #FIXME is there a good way to improve this ?
        @h_pw = hash(hash(params[:login][:password])+"<---Sekret--->"+@author.salt)
        
        @h_pw_orig = @author.password
        @salt = @author.salt
        if verify_against_hash_pair(params[:login][:password],[@author.password,@author.salt]) then
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
    if params[:commit] and params[:commit] == "Abbrechen" then
      redirect_to "/" and return
    end
    
    if session[:login] == "jap" then
      if params[:author] then
        if params[:author][:password] != params[:author][:password_confirmation] then
          @errors += "|Passwörter stimmen nicht überein| "
          #redirect_to :action=> "add" and return
        else

         pair = create_hash_pair params[:author][:password]
         attr = {:name => params[:author][:name],:password => pair[0],:salt => pair[1]}
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
  
  def show
    @title = "Anzeigen"
    if session[:login] == "jap" then
      if params[:author] then
        @select = false
        @a_id = params[:author][:id].to_i
        @author = Author.find(@a_id)
        
      else
        @select = true
        @a_sel = Author.all.sort        
      end
    else
      redirect_to "/" and return
    end
  end
  
  def change_pw
    
  end
  
  private
  
  def hash(plaintext)
    Digest::SHA2.hexdigest(plaintext)
  end
  
  def create_hash_pair(clear_password)
    pw = hash clear_password
    salt = hash Time.now.to_s
    [hash(pw + "<---Sekret--->" + salt),salt]
  end
  
  def verify_against_hash_pair(plaintext_password,pair)
    test = hash(hash(plaintext_password)+ "<---Sekret--->" + pair[1])
    test == pair[0]
  end
    
  
end