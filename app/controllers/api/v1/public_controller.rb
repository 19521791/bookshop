module Api
  module V1
    class PublicController < ApplicationController
      def health_check
        render(json: {
          status_code: 200,
          status: 'ok'
        })
      end

      def check_env
        render(json: {
          environment: ::ENV.fetch("RAILS_ENV"),
          variable: ::ENV.fetch("VARIABLE")
        })
      end
    end
  end
end