Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :books, only: [:index, :show, :search]
      # get 'books/', to: 'books#search'
      namespace :admin do
        post 'create-book', to: 'books#create', as: 'create_book'
        resources :books, only: [:index, :show, :update, :destroy]
      end
    end
  end
end
