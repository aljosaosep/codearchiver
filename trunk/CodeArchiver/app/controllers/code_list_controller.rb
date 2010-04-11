class CodeListController < ApplicationController
  	def index
		#@codes = Code.find_group_codes
		@categories = Category.find_root_categories
  	end

	def show
		@code = Code.find(params[:id])
		@comments = @code.getComments

    		respond_to do |format|
      			format.html # show.html.erb
      			format.xml  { render :xml => @code }
   		end
	end
end
