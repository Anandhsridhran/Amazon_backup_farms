Farmcentral::Application.routes.draw do

  resources :user_devices


  resources :inventory_reports


  resources :shipments


  resources :barns

  get 'barns/:id/last_reading', to: 'barns#last_reading'
  get 'barns/:id/last_event_report', to: 'barns#last_event_report'
  get 'barns/:id/last_shipment', to: 'barns#last_shipment'
  get 'barns/:id/last_inventory_report', to: 'barns#last_inventory_report'

  get 'barns/:farm_id/update_locations', to: 'barns#update_locations'
  get 'barns/:location_id/update_barns', to: 'barns#update_barns'

  match 'update_locations' => 'barns#update_locations', :as => :update_locations
  match 'update_barns' => 'barns#update_barns', :as => :update_barns

  get 'users/:role/role_changed', to: 'users#role_changed'
  match 'role_changed' => 'users#role_changed', :as => :role_changed




  post '/say_event/:id', to: 'say_event#show'

  resources :barn_configurations


  resources :pictures


  resources :dashboard

  resources :event_reports


  resources :readings

  # Each location has a ControllerAdmin (acts as authorized user for the controller there)
  resources :controller_admins
  resources :locations

  resources :barns do
    resources :controller_admins
    resource :barn_configuration, :path => 'settings'
  end

  get 'locations/:id/barns', to: 'locations#barns'

  resources :farms

  get 'farms/:id/locations', to: 'farms#locations'

  resources :hog_owners

  resources :users 

  get 'users/:id/farms', to: 'users#farms'

  resources :user_sessions

  root :to => 'dashboard#index'
  
  match 'logout' => 'user_sessions#destroy', :as => :logout



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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
