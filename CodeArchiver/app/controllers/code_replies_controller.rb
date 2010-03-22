class CodeRepliesController < ApplicationController
  # GET /code_replies
  # GET /code_replies.xml
  def index
    @code_replies = CodeReply.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @code_replies }
    end
  end

  # GET /code_replies/1
  # GET /code_replies/1.xml
  def show
    @code_reply = CodeReply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @code_reply }
    end
  end

  # GET /code_replies/new
  # GET /code_replies/new.xml
  def new
    @code_reply = CodeReply.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @code_reply }
    end
  end

  # GET /code_replies/1/edit
  def edit
    @code_reply = CodeReply.find(params[:id])
  end

  # POST /code_replies
  # POST /code_replies.xml
  def create
    @code_reply = CodeReply.new(params[:code_reply])

    respond_to do |format|
      if @code_reply.save
        flash[:notice] = 'CodeReply was successfully created.'
        format.html { redirect_to(@code_reply) }
        format.xml  { render :xml => @code_reply, :status => :created, :location => @code_reply }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @code_reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /code_replies/1
  # PUT /code_replies/1.xml
  def update
    @code_reply = CodeReply.find(params[:id])

    respond_to do |format|
      if @code_reply.update_attributes(params[:code_reply])
        flash[:notice] = 'CodeReply was successfully updated.'
        format.html { redirect_to(@code_reply) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @code_reply.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /code_replies/1
  # DELETE /code_replies/1.xml
  def destroy
    @code_reply = CodeReply.find(params[:id])
    @code_reply.destroy

    respond_to do |format|
      format.html { redirect_to(code_replies_url) }
      format.xml  { head :ok }
    end
  end
end
