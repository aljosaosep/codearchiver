class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.xml
  
  layout :default.to_s
  #before_filter :authorize
  
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    #@profile = Profile.find(params[:id])
    
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

    #respond_to do |format|
    #  format.html # new.html.erb
    #  format.xml  { render :xml => @codes }
    #nd
    
    @profile = Profile.find(:first, :conditions => {:user_id => session[:user_id]} )
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }      
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        flash[:notice] = 'Profile was successfully created.'
        format.html { redirect_to(@profile) }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])
    
    #@profile.email = 
    #puts "ATRIBUTIIIIIIIIIIIIIi"
    #for @enProfil in @profile.attribute_names
     # puts @enProfil
    #end
    #puts "PARAMETRIIIIII"
    
  #puts "PROFILE = " + @profile.to_s
  #puts "USER = " + @profile.user.to_s
    #@profile.update_attribute(:email, @profile.email)
    #@profile.update_attribute(:im, "drekkkk")
    #@profile.save
    #puts 'PRVI PARAMETER = '+  params[:IM]
	

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(@profile) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end

  #protected
  #   def authorize
  #      @profile = Profile.find(:first, :conditions => {:user_id => session[:user_id]}) #Profile.find(params[:id])

  #      unless isCurrentUserAuthor(@profile.user_id, session[:user_id])#User.find_by_id(session[:user_id])
  #	  flash[:notice] = "You are not authorized to do that." 
  #	   redirect_to :controller => 'main', :action => 'error404'
  #      end
  #   end
end
