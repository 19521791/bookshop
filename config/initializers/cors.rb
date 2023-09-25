Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:3000', '127.0.0.1:3000'

    resource '/file/list_all/', :headers => 'x-domain-token'
    resource '/file/at/*',
        methods: [:get, :post, :delete, :put, :patch, :options, :head],
        headers: 'x-domain-token',
        expose: ['Some-Custom-Response-Header'],
        max_age: 600
  end

  allow do
    origins '*'
    resource '/public/*', headers: :any, methods: :get
    resource '/api/v1/*',
        headers: :any,
        methods: :get,
        if: proc { |env| env['HTTP_HOST'] == 'api.example.com' }
  end
end