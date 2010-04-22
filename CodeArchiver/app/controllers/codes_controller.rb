class CodesController < ApplicationController
  # GET /codes
  # GET /codes.xml
  layout :default.to_s
  def index
    #@parameterX = params[:parameterX]
    #if(@parameterX.nil?)
     # puts "prazen"
    #else
    #  puts "=================" + @parameterX.to_s
    #end
    
    @tip = params[:tip]
    @idX = params[:idX]
    #@page = params[:page]
    
    if(params[:page].nil?)
      params[:page] = 1;
    end
    
    @activeProfile = Profile.find session[:user_id]
    
    if @tip == "kategorija"
      @codes = Code.find(:all, :conditions => {:category_id => @idX}, :limit => @activeProfile.listing, :offset => (@activeProfile.listing * (params[:page].to_i-1)))
      @numPages = (Code.find(:all, :conditions => {:category_id => @idX}).length / @activeProfile.listing.to_f).ceil
    elsif @tip == "jezik"
      @codes = Code.find(:all, :conditions => {:program_language_id => @idX}, :limit => @activeProfile.listing, :offset => (@activeProfile.listing * (params[:page].to_i-1)))
      @numPages = (Code.find(:all, :conditions => {:program_language_id => @idX}).length / @activeProfile.listing.to_f).ceil
    else
      @codes = Code.all(:limit => @activeProfile.listing, :offset => (@activeProfile.listing * (params[:page].to_i-1)))
      @numPages = (Code.all.length / @activeProfile.listing.to_f).ceil
    end
    
    @categories = Category.all
    @languages = ProgramLanguage.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @codes }
    end
  end

  def getAuthorName
   return User.find(@code.user_id).username
  end

  # GET /codes/1
  # GET /codes/1.xml
  def show
    @code = Code.find(params[:id])
	  @comments = @code.getComments
    @newcomment = Comment.new

    #profile potrebujemo za prikaz avatarjev ob komentarjih
    @profile = Profile.find(:first, :conditions => {:user_id => @code.user_id})
  
    #grades potrebujemo ker moramo imeti zbrane vse ocene za posamezno kodo
    @grades = Grade.find(:all , :conditions => {:code_id => @code.id})
    
    @gradesPlus = 0
    @gradesMinus = 0
    for grade in @grades
      if grade.value == 1
        @gradesPlus+=1
      else
        @gradesMinus+=1
      end
    end
    
    puts "SEEEEEEEESSSSSIIIIOOOONNNN " + session[:user_id].to_s
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
    puts "qlllllllllll"
    puts @gradeUser.to_s
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

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code }
    end
  end

  # GET /codes/1/edit
  def edit
    @code = Code.find(params[:id])
  end

  # POST /codes
  # POST /codes.xml
  def create
    @code = Code.new(params[:code])
	  # TODO: check if user is NOT logged in!!!! 
	  @code.user_id = session[:user_id] # gets user id from session (user current logged in) and sets is to code
    

    respond_to do |format|
      if @code.save
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
  
end
