Rails.application.routes.draw do
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get '/groups/:id/join', to: 'groups#join', as: 'group_join'
  get '/groups/:id/memberships', to: 'groups#memberships', as: 'group_membership'
  get '/groups/:id/users', to: 'groups#users', as: 'group_users'
  patch '/groups/:id/users', to: 'groups#approve', as: 'approved_memberships'
  get '/answers/:id/edit', to: 'answers#edit', as: 'edit_answer'
  get '/answers/:id/destroy', to: 'answers#destroy', as: 'delete_answer'
  get '/users/:id/adminpanel', to: 'users#admin', as: 'admin'
  get '/stats', to: 'pages#stats', as: 'stats'
  resources :users, :tags, :sessions
  resources :groups do 
     resources :questions do 
        resources :answers
      end
  end
  get '/', to: 'pages#home', as: 'home'

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
