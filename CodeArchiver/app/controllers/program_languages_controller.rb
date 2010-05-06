class ProgramLanguagesController < ApplicationController
  # GET /program_languages
  # GET /program_languages.xml
  before_filter :authorize
  layout :default.to_s
  def index
    @program_languages = ProgramLanguage.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @program_languages }
    end
  end

  # GET /program_languages/1
  # GET /program_languages/1.xml
  def show
    @program_language = ProgramLanguage.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @program_language }
    end
  end

  # GET /program_languages/new
  # GET /program_languages/new.xml
  def new
    @program_language = ProgramLanguage.new

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "program_language", :action => "new")
    @admin_log.save

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @program_language }
    end
  end

  # GET /program_languages/1/edit
  def edit
    @program_language = ProgramLanguage.find(params[:id])

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "program_language", :action => "edit")
    @admin_log.save
  end

  # POST /program_languages
  # POST /program_languages.xml
  def create
    @program_language = ProgramLanguage.new(params[:program_language])

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "program_language", :action => "create")
    @admin_log.save

    respond_to do |format|
      if @program_language.save
        flash[:notice] = 'ProgramLanguage was successfully created.'
        format.html { redirect_to(@program_language) }
        format.xml  { render :xml => @program_language, :status => :created, :location => @program_language }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @program_language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /program_languages/1
  # PUT /program_languages/1.xml
  def update
    @program_language = ProgramLanguage.find(params[:id])

    respond_to do |format|
      if @program_language.update_attributes(params[:program_language])
        flash[:notice] = 'ProgramLanguage was successfully updated.'
        format.html { redirect_to(@program_language) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @program_language.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /program_languages/1
  # DELETE /program_languages/1.xml
  def destroy
    @program_language = ProgramLanguage.find(params[:id])
    @program_language.destroy

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "program_language", :action => "destroy")
    @admin_log.save

    respond_to do |format|
      format.html { redirect_to(program_languages_url) }
      format.xml  { head :ok }
    end
  end


end
