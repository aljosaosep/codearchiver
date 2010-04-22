ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "main"
  
  map.myprofile 'profile', 
    :controller => 'profiles',
    :action => 'show'
  
  map.userji 'users/:username',
    :controller => 'users',
    :action => 'show'

  map.signup 'signup', 
    :controller => 'users', 
    :action => 'new'
  
  map.logout 'logout', 
    :controller => 'sessions', 
    :action => 'destroy'
  
  map.login 'login', 
    :controller => 'sessions', 
    :action => 'create'
  
  map.help 'help',
    :controller => 'help',
    :action => 'index'
  
  map.coddes 'create_comment', :controller => 'codes', :action => 'create_comment'
  
  #20.04.2010
  map.graddes 'new_grade', :controller => 'codes', :action => 'new_grade'
  map.gradddes 'gradeChange', :controller => 'codes', :action => 'gradeChange'
  map.gradeCreate 'createGrade', :controller => 'codes', :action => 'createGrade'
  
  map.resources :sessions

  map.resources :users

  map.resources :code_replies

  map.resources :comments

  map.resources :grades

  map.resources :codes

  map.resources :subcategories

  map.resources :categories

  map.resources :program_languages

  map.resources :types

  map.resources :profiles

  map.resources :code_list

  map.resources :subcategories

  map.resources :profiles

  map.resources :types

  map.resources :categories
  
  map.connect "*anything",
    :controller => "main",
    :action => "error404"
end
