# Rails.application.config.middleware.insert_before(0, Rack::Cors) do
#   allow do
#     origins *Rails.application.credentials.dig(Rails.env.to_sym, :allowed_origins).to_a

#     resource '*',
#       headers: :any,
#       methods: %i[get post put patch delete options head]
#   end
# end
