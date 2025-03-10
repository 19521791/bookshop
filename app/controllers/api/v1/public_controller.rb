module Api
  module V1
    class PublicController < ApplicationController
      def health_check
        render(json: {
          status_code: 200,
          status: 'ok'
        })
      end
    end
  end
end