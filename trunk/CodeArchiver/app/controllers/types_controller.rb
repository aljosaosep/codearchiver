class TypesController < ApplicationController
  # GET /types
  # GET /types.xml
  before_filter :authorize
  layout :default.to_s
  def index
    @types = Type.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @types }
    end
  end

  # GET /types/1
  # GET /types/1.xml
  def show
    @type = Type.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/new
  # GET /types/new.xml
  def new
    @type = Type.new

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "types_controller", :action => "new")
    @admin_log.save

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @type }
    end
  end

  # GET /types/1/edit
  def edit
    @type = Type.find(params[:id])

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "types_controller", :action => "edit")
    @admin_log.save
  end

  # POST /types
  # POST /types.xml
  def create
    @type = Type.new(params[:type])

	#  
    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "types_controller", :action => "create")
    @admin_log.save


    respond_to do |format|
      if @type.save
        flash[:notice] = 'Type was successfully created.'
        format.html { redirect_to(@type) }
        format.xml  { render :xml => @type, :status => :created, :location => @type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /types/1
  # PUT /types/1.xml
  def update
    @type = Type.find(params[:id])

    respond_to do |format|
      if @type.update_attributes(params[:type])
        flash[:notice] = 'Type was successfully updated.'
        format.html { redirect_to(@type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /types/1
  # DELETE /types/1.xml
  def destroy
    @type = Type.find(params[:id])
    @type.destroy

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "types_controller", :action => "destroy")
    @admin_log.save

    respond_to do |format|
      format.html { redirect_to(types_url) }
      format.xml  { head :ok }
    end
  end
end
