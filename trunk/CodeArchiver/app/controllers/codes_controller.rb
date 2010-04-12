class CodesController < ApplicationController
  # GET /codes
  # GET /codes.xml
  layout :default.to_s
  def index
    @codes = Code.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @codes }
    end
  end



def getAuthorName
 # @author = User.find(@code.user_id).username
 return User.find(@code.user_id).username
end



  # GET /codes/1
  # GET /codes/1.xml
  def show
    	@code = Code.find(params[:id])
	@comments = @code.getComments

	@newcomment = Comment.new

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
        format.html { redirect_to(@code) }
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