MicrofinanciacionesApp::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  resources :cart_items
  resources :cart
  resources :proyectos do
    collection do
      get 'pb'
      get 'pb/:tag', to: 'proyectos#pb', as: 'tag'
    end
    member do
      get 'modal'
    end
  end
  resources :users do
    member do
      put 'adm_confirm'
      get 'confirm/:confirmation_code', action: 'confirm'
      get 'aportations'
      post 'delete'
    end
  end

  resources :sessions, only: [:new, :create, :destroy]
  resources :payment_notifications, only: [:create]
  resources :orders do
    member do
      get 'admin'
    end
  end

  resources :suggests
  resources :order_transactions
  resources :blog_posts do
    member do
      put 'approve'
    end
  end
  resources :password_ressets
  resources :volunteers do
    member do
      put 'send_answer'
    end
  end

  resources :orders do
    new do
      get 'express'
    end
  end

  match '/blog', to: 'blog_posts#home', via: 'get'
  match '/proyectosShow', to: 'proyectos#show', via: 'get'
  match '/cartItemCreate', to: 'cart_items#createjs', via: 'post'
  match '/cartitem/indexadmin', to: 'cart_items#indexAdmin', via: 'get'
  match '/cart', to: 'proyectos#show', via: 'get'
  match '/getNumberOfItems', to: 'cart#get_number_of_items', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  match '/legal', to: 'static_pages#legal', via: 'get'
  match '/cookies_info', to: 'static_pages#cookies_info', via: 'get'
  root to: 'static_pages#home'
  match 'home/:tag', to: 'static_pages#home', via: 'get', as: 'category'
  match '/signup', to: 'users#new', via: 'get'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/contact', to: 'suggests#new', via: 'get'
  match '/deleteAttachment', to: 'proyectos#destroy_attachment', via: 'delete'

  get 'auth/:provider/callback', to: 'sessions#createFb'

  get '*path' => redirect('/')

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
