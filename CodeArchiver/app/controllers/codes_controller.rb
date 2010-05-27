class CodesController < ApplicationController

  before_filter :loggedin, :only => [:create_comment, :createGrade, :gradeChange] # In order to add codereply you must be logged in

  before_filter :onlyAuthor, :only => [:show, :edit, :destroy]
  # GET /codes
  # GET /codes.xml
  layout :default.to_s
  def index
 
    if(params[:page].nil?)
      params[:page] = 1;
    end
    
    if (!params[:search].nil?)
      @codes = Code.search params[:search][:text]
    else
      if ( !params[:lang].nil? and !params[:cat].nil? ) 
        @codes = Code.find :all, :conditions => {'category_id' => params[:cat], 'program_language_id' => params[:lang], 'private' => false}, :order => 'updated_at DESC'
      elsif (!params[:lang].nil?)
        @codes = Code.find :all, :conditions => {'program_language_id' => params[:lang], 'private' => false}, :order => 'updated_at DESC'
      elsif (!params[:cat].nil?)
        @codes = Code.find :all, :conditions => {'category_id' => params[:cat], 'private' => false}, :order => 'updated_at DESC'
      else
        @codes = Code.find :all, :conditions => {'private' => false}, :order => 'updated_at DESC'
      end
    end
    
    @listing = 10
    if !session[:user_id].nil? then
      @activeProfile = Profile.find session[:user_id]
      @listing = @activeProfile.listing    
    end
    
    @numPages = (@codes.length / @listing.to_f).ceil
    @codes = @codes[(params[:page].to_i-1)*@listing, @listing]
    
    @categories = Category.all
    @languages = ProgramLanguage.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @codes }
    end
  end

  ### OBSOLETE?!?
  def getAuthorName
   return User.find(@code.user_id).username
  end

  # Lists all users's codes and is avalible only to user.
  # User can access (his!) private codes only here.
  def mycode
    @codes = Code.find(:all, :conditions => {:user_id => session[:user_id]}) # Get ALL codes, even private, since this is user's private code view

    @listing = 10
    if !session[:user_id].nil? then
      @activeProfile = Profile.find session[:user_id]
      @listing = @activeProfile.listing    
    end
    
    @numPages = (@codes.length / @listing.to_f).ceil
  #  @codes = @codes[(params[:page].to_i-1)*@listing, @listing]
    
    @categories = Category.all
    @languages = ProgramLanguage.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @codes }
    end
  end


  # GET /codes/1
  # GET /codes/1.xml
  def show
    @code = Code.find(params[:id])
    @canedit = isCurrentUserAuthorOrAdmin(@code.user_id, session[:user_id])
    @cancomment = isUserLoggedIn(session[:user_id])
    @isPrivate = @code.private

    
    @isReplyToCode = CodeReply.find(:first, :conditions => {:child_id => @code.id})
    @CodeReply = -1
    if @isReplyToCode != nil
      #is reply to other code
      @CodeReply = Code.find(:first, :conditions => {:id => @isReplyToCode.code_id})
    end
    
    @CodeHasReplies = CodeReply.find(:all, :conditions => {:code_id => @code.id})
    @CodeReplies = -1
    if @CodeHasReplies != nil
      @codes = Array.new
      for cr in @CodeHasReplies
          @codes << Code.find(cr.child_id)
      end     
      @CodeReplies = @codes         
    end
    
    @comments = @code.getComments
    @newcomment = Comment.new

    #profile potrebujemo za prikaz avatarjev ob komentarjih
    @profile = Profile.find(:first, :conditions => {:user_id => @code.user_id})
  
    #grades potrebujemo ker moramo imeti zbrane vse ocene za posamezno kodo
    @grades = Grade.find(:all , :conditions => {:code_id => @code.id})

    # prog_lang_brush potrebujemo za barvanje sintakse
    @prog_lang_brush = ProgramLanguage.find (@code.program_language_id).syntax_tag

    #povecevanje stevca za ogled kode
    if(@code.views != nil)
      @code.views += 1
      @code.save
    else
      @code.views=0
      @code.save
    end
    
    @gradesPlus = 0
    @gradesMinus = 0
    for grade in @grades
      if grade.value == 1
        @gradesPlus+=1
      else
        @gradesMinus+=1
      end
    end
    
    puts @gradesPlus.to_s
    puts @gradesMinus.to_s
    #gradeUser potrebujemo zato da bomo vedeli kaksno oceno je prijavljeni uporabnik ze podal
    @gradeUser = 0
    if session[:user_id]!=nil
      @gradeUser = Grade.find(:first, :conditions => {:code_id => @code.id, :user_id => session[:user_id]})
      if @gradeUser == nil
        @gradeUser=0
      else
          @gradeUser = @gradeUser.value
      end
    end
#    puts "qlllllllllll"
#    puts @gradeUser.to_s
    #@gradeUser = Grade.find(:first, conditions => {:code_id => @code.id, :user_id => session[:user_id]})
    	respond_to do |format|
      		format.html # show.html.erb
      		format.xml  { render :xml => @code }
    	end
  end

  # GET /codes/new
  # GET /codes/new.xml
  def new
    @code = Code.new
    #@isResponse = params[:response]
    #puts 'RESPONSE-new ============' + @isResponse.to_s 
    #@parent=0
    #if @isResponse == 1  #means that code is response to other code
    #  @parent = params[:parentID]
    #end
    
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/1/edit
  def edit
    # get the code
    @code = Code.find(params[:id])

    # authenticate user
    unless isCurrentUserAuthorOrAdmin(@code.user_id, session[:user_id]) #@code.user_id != session[:user_id] # is user currently logged in code author?
       flash[:notice] = "You are not authorised to do that." # he isn't!
       redirect_to :controller => 'codes', :action => 'show'
    end
  end

  # POST /codes
  # POST /codes.xml
  def create
    # authenticate user
    if session[:user_id].nil? then # is user not logged in?
       flash[:notice] = "You are not logged in."
       redirect_to :controller => 'sessions', :action => 'create'
    end

    @code = Code.new(params[:code])
    desc = @code.description
    puts "--------------------------------------------------------------------------------------------------------"
    puts desc
    
    @code.description = desc.gsub("\n","<br/>")
    
    puts "------------------------------------------------------------------------------------------------------"
   # puts desc
    
    if @code.private == nil
	     @code.private = false
    end

    @code.user_id = session[:user_id] # gets user id from session (user current logged in) and sets is to code
    
    

    respond_to do |format|
      if @code.save   #if code is saved and code is response to other code
        @isResponse = params[:response] 
        if @isResponse == '1'
          @parent = params[:parentID]
          @codeReply = CodeReply.new
          @codeReply.child_id = @code.id   #adding relation in db
          @codeReply.code_id = @parent.to_i
          @codeReply.save
        end
        flash[:notice] = 'Code was successfully created.'
        format.html { redirect_to("/codes") }
        format.xml  { render :xml => @code, :status => :created, :location => @code }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /codes/1
  # PUT /codes/1.xml
  def update
    @code = Code.find(params[:id])

    respond_to do |format|
      if @code.update_attributes(params[:code])
        flash[:notice] = 'Code was successfully updated.'
        format.html { redirect_to(@code) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.xml
  def destroy
    @code = Code.find(params[:id])
    @code.destroy

    respond_to do |format|
      format.html { redirect_to(codes_url) }
      format.xml  { head :ok }
    end
  end
  
	#################################################
	# create_comment action
	#
	# creates new comment, gets comment content and
	# code id from form
	# saves comment to database and redirects back
	#################################################
	def create_comment
		@comment = Comment.new(params[:comment])
		@comment.user_id = session[:user_id]
		@comment.code_id = (params[:code_id])


    		respond_to do |format|
      			if @comment.save
        			flash[:notice] = 'Comment was successfully created.'
        			format.html { redirect_to(:action => 'show', :id => params[:code_id] ) }
        			##format.xml  { render :xml => @code, :status => :created, :location => @comment }
      			else
        			format.html { render :action => 'show', :id => params[:code_id] }
        		#	format.xml  { render :xml => @code.errors, :status => :unprocessable_entity }
      			end
		end
end

def new_grade
  
end

def gradeChange
  @code = Code.find(params[:codeXid])
  @grade = Grade.find(:first, :conditions => {:code_id => @code.id, :user_id => session[:user_id]})
  @grade.value = params[:valueX]
  @grade.save
  redirect_to(:action => 'show', :id => @grade.code_id )
end

def createGrade
  @grade = Grade.new
  @grade.user_id = params[:userXid]
  @grade.code_id = params[:codeXid]
  @grade.value = params[:valueX]
  @grade.save
  redirect_to(:action => 'show', :id => @grade.code_id )
end


  def 
  
   def category
      @category = Category.find(:first, :conditions => {:name => params[:name]})
      puts "KATEGORIJA ID = "+  @category.id.to_s
      @codes = Code.find(:all, :conditions => {:category_id => @category.id})
  end
  
  def language
      @language = ProgramLanguage.find(:first, :conditions => {:language_name => params[:name]})
      puts "PROGRAM LANGUAGE ID = "+  @language.id.to_s
      @codes = Code.find(:all, :conditions => {:program_language_id => @language.id})
  end

  protected
    # Stuff like private code even admin can't manage
    def onlyAuthor
	@code = Code.find(params[:id])

	unless @code.private == nil
		if @code.private == true
			unless isCurrentUserAuthor(@code.user_id, session[:user_id])
				# Code is private
				puts "--- onlyAuthor fAiL ---"
	  			flash[:notice] = "Private code, you should be an author." 
  	  			redirect_to :controller => 'main', :action => 'error404'
			end
		end
	end
    end
  #	def isUserOrOwner
  #	end
  #   def authorize
  #      unless User.find_by_id(session[:user_id])
  #	   flash[:notice] = "Please log in."
  # 	   redirect_to :controller => 'sessions', :action => 'create'
  #      end
  #   end
  
end
