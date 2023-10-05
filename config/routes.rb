Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :books, only: [:index, :show]

      resources :categories, only: [:index, :show]

      post '/customers/login', to: 'customers#login'

      post '/customers/register', to: 'customers#create'

      resources :customers, only: [:index, :show, :update, :destroy]

      namespace :admin do

        post 'create-book', to: 'books#create', as: 'create_book'

        resources :books, only: [:index, :show, :update, :destroy]

        post 'create-category', to: 'categories#create'

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