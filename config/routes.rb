Rails.application.routes.draw do

  authenticated :user do
    root :to => 'shifts#index' , :as => 'authenticated_root'
  end

  root 'landing_page#index'

  devise_for :users

  resources :users, except: :show do 
    resources :shifts do
      resources :requests
    end
  end

  get '/shift_info/:shift_date/', to: 'shifts#shift_info', as: :shift_info
  get '/users/:user_id/requests', to: 'requests#inbox', as: :requests_inbox
  patch '/users/:user_id/requests/:id/accept', to: 'requests#accept', as: :requests_accept
  patch '/users/:user_id/requests/:id/reject', to: 'requests#reject', as: :requests_reject
  patch '/users/:user_id/requests/:id/seen', to: 'requests#mark_as_seen', as: :requests_seen


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
