VideoPreviewSystem::Application.routes.draw do
  root 'clients#index'
  get "clients/index"

  get "clients/" => redirect('clients/login')

  get "clients/logout" => 'clients#logout', as: :logout

  match 'clients/login', to: 'clients#login', via: [:get, :post], as: :login

  get "admin/" => 'admin#index', as: :admin

  # get "admin/clients" => 'admin/clients#index'

  #get "clients/login", as: :login
  #post "clients/login", as: :login

  namespace :admin do
    resources :clients, except: [:new, :show, :edit] do
      member do
        get "mail/" => 'clients#mail'
        post "mail/" => 'clients#mail_send'
      end
      resources :videos, except: [:new, :show, :edit] 
      
    end
  end

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
