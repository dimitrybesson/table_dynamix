Rails.application.routes.draw do


  root 'restaurants#index'
  resources :restaurants, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :reservations, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :reviews, only: [:create, :edit, :update, :destroy]
  end

  # Nice use of a singular resource on Owner here! Very elegant.
  resource :owners, only: [:new, :create, :show]
  resources :customers, only: [:index, :new, :create, :show]
  resource :sessions, only: [:new, :create]
  resources :categories, only: %i(index show)

  delete '/sessions/' => 'sessions#destroy', as: 'logout'

  # Instead of tacking on non-RESTful methods to the RestaurantsController,

  # you should create a SearchesController with a new method and app/views/searches/new.html.erb (to show the search form)
  # and a create method and app/views/searches/create.html.erb (to execute the search and present the results).

  get '/search' => 'restaurants#search', as: 'search'
  get '/search_results' => 'restaurants#search_results', as: 'search_results'

  # get 'reviews/create'
  #
  # get 'reviews/edit'
  #
  # get 'reviews/update'
  #
  # get 'reviews/destroy'

  # get 'sessions/new'
  #
  # get 'sessions/create'
  #
  # get 'sessions/destroy'
  #
  # get 'owners/new'
  #
  # get 'owners/create'
  #
  # get 'owners/index'
  #
  # get 'customers/new'
  #
  # get 'customers/create'
  #
  # get 'customers/index'
  #
  # get 'reservations/new'
  #
  # get 'reservations/create'
  #
  # get 'reservations/index'
  #
  # get 'restaurants/index'
  #
  # get 'restaurants/show'
  #
  # get 'restaurants/new'
  #
  # get 'restaurants/create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
