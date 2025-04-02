allowed_origins = [
  'http://localhost:5173',
  'http://127.0.0.1:5173',              
  'https://172.96.190.154',           
  'https://douglusnguyen.site'                       
].compact

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins do |source, _|
      allowed_origins.any? { |origin| 
        origin.is_a?(Regexp) ? origin.match?(source) : origin == source
      }
    end

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end