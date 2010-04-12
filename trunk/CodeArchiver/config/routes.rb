ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => "main"
 
  
  map.codesbycategory 'codes/category/:name', :controller => 'codes', :action => 'category'
  map.codesbylanguagename 'codes/language/:name', :controller => 'codes', :action => 'language'
  
  map.myprofile 'profile', :controller => 'profiles', :action => 'show'
  
   #dodano za edit 8.4.2010
 # map.profile 'profile/:id', :controller => 'profiles', :action => 'edit'
  
  #6.4.2010
  map.users 'users/:username', :controller => 'users', :action => 'show'
 # map.users.connect ':controller/:action/:username'
  
  
  #new -> create
  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
  map.resources :sessions

  map.resources :users

  map.signup 'signup', :controller => 'users', :action => 'new'
  map.logout 'logout', :controller => 'sessions', :action => 'destroy'
  map.login 'login', :controller => 'sessions', :action => 'new'
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

#  map.resources :users

 # map.resources :users

  #map.resources :users

  map.resources :subcategories

  map.resources :subcategories

  map.resources :subcategories

  map.resources :subcategories

  map.resources :profiles

  map.resources :types

  map.resources :categories

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
