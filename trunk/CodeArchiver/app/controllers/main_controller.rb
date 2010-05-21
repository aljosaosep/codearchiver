class MainController < ApplicationController
  layout :default.to_s
  
  def index
    @top_5 = Code.find(:all, :order => "popularity DESC", :limit => 5)
    @top_5_comments = Comment.find(:all, :order => "updated_at DESC", :limit => 5)
  end
  
end
