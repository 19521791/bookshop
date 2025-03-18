module Api
  module V1
    class PublicController < ApplicationController
      before_action :authenticate_public, only: [:check_valid_signed_url, :get_signed_url]

      def check_health
        ::Utils.logger_color('Check Health')
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

      def check_valid_signed_url
        cmd = ::V1::CheckSignedUrl.call
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
         render(json: cmd.errors, status: 422)
        end
      end

      def get_signed_url
        cmd = ::V1::GetSignedUrl.call
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
         render(json: cmd.errors, status: 422)
        end
      end
    end
  end
end