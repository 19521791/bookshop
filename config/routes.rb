Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      get '/health', to: 'public#check_health'

      get '/check_env', to: 'public#check_env'

      get '/check_signed_url', to: 'public#check_valid_signed_url'

      get '/signed_url', to: 'public#get_signed_url'

      resources :books, only: [:index, :show]

      resources :categories, only: [:index, :show]

      get '/categories/:id/books', to: 'categories#list_book'

      post '/customers/login', to: 'customers#login'

      post '/customers/register', to: 'customers#create'

      resources :customers, only: [:index, :show, :update, :destroy]

      namespace :admin do

        post 'create-book', to: 'books#create', as: 'create_book'

        resources :books, only: [:index, :show, :update, :destroy]

        post 'create-category', to: 'categories#create'

        get '/categories/:id/books', to: 'categories#list_book'

        resources :categories, only: [:index, :show, :update, :destroy]

        post '/login', to: 'admins#login'

        post '/register', to: 'admins#create'

        get '/', to: 'admins#index'

        get '/:id', to: 'admins#show'

        put '/:id', to: 'admins#update'

        delete '/:id', to: 'admins#destroy'
      end
    end
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
end