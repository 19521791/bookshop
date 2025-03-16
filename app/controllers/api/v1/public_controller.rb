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

      def check_valid_signed_url
        render(json: {
          records: ::Attachment.all.map { |attachment| { file: attachment.file_name, expired_at: attachment.expired_at.in_time_zone("Asia/Ho_Chi_Minh") } } 
        })
      end
    end
  end
end