Rails.application.routes.draw do
  resources :transactions

  resources :bank_accounts

  get ':controller/:action'
  get ':locale/:controller/:action'

  get '/confirm/:user/:hash' => 'front#confirm', :as => :register_path

  get '/login' => 'front#login'
  get '/register' => 'front#register'
  get '/logout' => 'front#logout'
  get '/dashboard' => 'dashboard#index', :as => :dashboard_home

  post "/login" => "front#login", :as => :login_form
  post "/register" => "front#register", :as => :register_form

  post '/transactions/:id/edit' => 'transactions#edit', :as => :transaction_import_form
  post '/transactions/:id/import' => 'transactions#import', :as => :transaction_import

  get '/categorize' => 'categorizes#index', :as => :categorize

  post '/categorize/addCategorie.json' => 'categorizes#addCategorie'

  get '/report/line' => 'diagrams#line', :as => :report1
  get '/report/pie' => 'diagrams#pie', :as => :report2

  get '/categorize/delCategorie' => 'categorizes#delCategorie', :as => :delete_categorie

  post '/report/data.json' => 'diagrams#data'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'front#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
