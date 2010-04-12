class CodeListController < ApplicationController
  	def index
		#@codes = Code.find_group_codes
		@categories = Category.find_root_categories
  	end

	def show
		@code = Code.find(params[:id])
		@comments = @code.getComments

		@comment = Comment.new
		@comment.user_id = session[:user_id]
		@comment.code_id = Code.find(params[:id]).id

		#self.new_comment

    		respond_to do |format|
      			format.html # show.html.erb
      			format.xml  { render :xml => @code }
   		end
	end


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
	
end
