RateYourWriting::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'
  match 'login' => 'home#login', :via => [:get, :post]
  get 'login_with_token' => 'home#login_with_token'
  get 'settings' => 'home#settings'
  get 'register' => 'home#register'
  get 'logout' => 'home#logout'
  get 'about' => 'home#about'
  get 'markdown_help' => 'home#markdown_help'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase
  post 'submissions/:id/vote' => 'submissions#vote', :as => :vote
  post 'submissions/:id/comment' => 'submissions#comment', :as => :comment
  get 'submissions/:id/revisions' => 'submissions#revisions', :as => :revisions
  get 'users/:id/verify' => 'users#verify', :as => :verification
  get 'users/:id/message' => 'users#message', :as => :send_message
  post 'users/:id/preferences' => 'users#preferences', :as => :preferences
  get 'messages/:id/reply' => 'messages#reply', :as => :reply

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  resources :users
  resources :submissions
  resources :messages
  resources :news_items
  resources :quotes

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
