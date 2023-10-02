Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      get '/books/:book_id', to: 'books#show'

      resources :books

      post '/customers/login', to: 'customers#login'

      post '/customers/register', to: 'customers#register'

      get '/customers/:user_id', to: 'customers#show'

      put '/customers/:user_id', to: 'customers#update'

      delete 'customers/:user_id', to: 'customers#destroy'

      resources :customers

      namespace :admin do

        post 'create-book', to: 'books#create', as: 'create_book'

        get '/books/:book_id', to: 'books#show'

        resources :books, only: [:index, :show, :update, :destroy]

        post '/login', to: 'admins#login'

        post '/register', to: 'admins#register'

        get '/', to: 'admins#index'

        get '/:user_id', to: 'admins#show'

        put '/:user_id', to: 'admins#update'

        delete '/:user_id', to: 'admins#destroy'
      end
    end
  end
end
