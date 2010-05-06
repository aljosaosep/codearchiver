class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  layout :default.to_s


  # Action filter
  before_filter :authorize, :except => [:new, :create] #:only => [:edit, :update, :destroy, :show] # For editing you must be authorised
  before_filter :loggedin, :only => [:new, :create] # In order to add comment you must be logged in

  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @comment = Comment.new
    @comment.user_id = session[:user_id]
    @comment.save

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "comments", :action => "new")
    @admin_log.save

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "comments", :action => "edit")
    @admin_log.save
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "comments", :action => "create")
    @admin_log.save

    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(@comment) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(@comment) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    @admin_log = AdminLog.new(:aid=> session[:user_id], :controller => "comments", :action => "destroy")
    @admin_log.save

    respond_to do |format|
      format.html { redirect_to(comments_url) }
      format.xml  { head :ok }
    end
  end
end
