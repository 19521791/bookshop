Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      get '/health', to: 'public#check_health'

      get '/check_env', to: 'public#check_env'

      get '/check_signed_url', to: 'public#check_valid_signed_url'

      get '/signed_url', to: 'public#get_signed_url'

      post '/upload_file', to: 'public#upload_file'

      get '/check_consistent_object_cloud', to: 'public#check_existed_object_in_s3'

      get 'raise-error', to: 'errors#trigger'
    end
  end
end

Rails.application.routes.draw do
  mount Sidekiq::Web => "/sidekiq"
end
