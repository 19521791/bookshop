module Api
  module V1
    class ErrorsController < ApplicationController
      def trigger
        raise "Test ExceptionNotification error"
      end
    end
  end
end
