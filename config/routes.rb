Circl::Application.routes.draw do

  resources :products

  resources :users do
    member do
      get :following, :followers
      put :uploader_toggle
    end
  end
	
  resources :sessions, :only => [:new_sess, :create, :destroy]
  resources :microposts,    :only => [:create, :destroy]
  resources :relationships, :only => [:create, :destroy]
  resources :file_sharing_relationships, :only => [:create, :destroy]
  resources :resources
  resources :shared_items
	#, :key => :name - this can be used to change the indexing of the users

  root :to => "pages#home" 
  match '/contact', :to => 'pages#contact'
  match '/about',   :to => 'pages#about'
  match '/signup', :to => 'pages#home'
  match '/new_sess', :to => 'sessions#new_sess'
  match '/signin', :to => 'pages#home'
  match '/help',    :to => 'pages#help'
  match '/signout', :to => 'sessions#destroy'
  match '/share_user_index' => 'resources#share_user_index'
  match 'download' => 'resources#download'
  match 'yourfiles' => 'resources#files'
  match 'sharedfiles' => 'resources#shared_files'
  match 'yourlinks' => 'resources#links'
  match 'sharedlinks' => 'resources#shared_links'
  match '/refresh_list' => 'resources#refresh_list'
  match 'resources/new' => 'resources#create', :via => :post

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
