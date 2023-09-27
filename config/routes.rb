Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'books/search', to: 'books#search'
      resources :books, only: [:index, :show]
      get 'customers/register', to: 'customers#index'
      post 'customers/register', to: 'customer#create'
      # resources :customers
      namespace :admin do
        post 'create-book', to: 'books#create', as: 'create_book'
        resources :books, only: [:index, :show, :update, :destroy]
      end
    end
  end
end
