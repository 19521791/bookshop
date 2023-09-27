Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/books/:book_id', to: 'books#show'
      resources :books
      namespace :admin do
        post 'create-book', to: 'books#create', as: 'create_book'
        get '/books/:book_id', to: 'books#show'
        resources :books, only: [:index, :show, :update, :destroy]
      end
    end
  end
end
