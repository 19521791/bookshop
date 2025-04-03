Rails.application.config.middleware.insert_before(0, Rack::Cors) do
  allow do
    origins ['http://localhost:5173', 'https://hub.douglusnguyen.site', 'https://douglusnguyen.site']

    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head]
  end
end
