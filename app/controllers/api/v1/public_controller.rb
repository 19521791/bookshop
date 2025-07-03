module Api
  module V1
    class PublicController < ApplicationController
      skip_before_action :verify_authenticity_token

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
        cmd = ::V1::Aws::CheckSignedUrl.call
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
         render(json: cmd.errors, status: 422)
        end
      end

      def get_signed_url
        cmd = ::V1::Aws::GetSignedUrl.call
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
         render(json: cmd.errors, status: 422)
        end
      end

      def upload_file
        cmd = ::V1::Aws::UploadFile.call(params)
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
          render(json: cmd.errors, status: 422)
        end
      end

      def check_existed_object_in_s3
        cmd = ::V1::Aws::CheckConsistentS3Object.call
        if cmd.success?
          render(json: cmd.result, status: 200)
        else
          render(json: cmd.errors, status: 422)
        end
      end
    end
  end
end
