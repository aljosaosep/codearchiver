class AdminLogsController < ApplicationController
  # GET /admin_logs
  # GET /admin_logs.xml
  before_filter :authorize
  layout :default.to_s
  def index
    @admin_logs = AdminLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_logs }
    end
  end

  # GET /admin_logs/1
  # GET /admin_logs/1.xml
#  def show
#    @admin_log = AdminLog.find(params[:id])

  #  respond_to do |format|
  #    format.html # show.html.erb
  #    format.xml  { render :xml => @admin_log }
  #  end
 # end

  # GET /admin_logs/new
  # GET /admin_logs/new.xml
  def new
    @admin_log = AdminLog.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_log }
    end
  end

  # GET /admin_logs/1/edit
#  def edit
#    @admin_log = AdminLog.find(params[:id])
#  end

  # POST /admin_logs
  # POST /admin_logs.xml
  def create
    @admin_log = AdminLog.new(params[:admin_log])

    respond_to do |format|
      if @admin_log.save
        flash[:notice] = 'AdminLog was successfully created.'
        format.html { redirect_to(@admin_log) }
        format.xml  { render :xml => @admin_log, :status => :created, :location => @admin_log }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin_logs/1
  # PUT /admin_logs/1.xml
#  def update
#    @admin_log = AdminLog.find(params[:id])

#    respond_to do |format|
#      if @admin_log.update_attributes(params[:admin_log])
#        flash[:notice] = 'AdminLog was successfully updated.'
#        format.html { redirect_to(@admin_log) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @admin_log.errors, :status => :unprocessable_entity }
#      end
#    end
#  end

  # DELETE /admin_logs/1
  # DELETE /admin_logs/1.xml
  def destroy
    @admin_log = AdminLog.find(params[:id])
    @admin_log.destroy
  end
end
