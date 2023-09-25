module ApiResponse
    extend ActiveSupport::Concern

    def handle_respone(command, action, message)
        if command.success?
          is_success(command.result, success_status_code(action))
        else
          is_error(message, command.errors.full_messages)
        end
    end

    private

    def is_success(data, status)
        render json: {
            status: status,
            data: data
        }
    end

    def is_error(message, errors = [], status = :unprocessable_entity)
        render json: {
            status: status,
            message: message,
            errors: errors
        }
    end

    def success_status_code(action)
        if action == 'create'
          :created
        elsif action == 'destroy'
          :no_content
        else
          :ok
        end
      end
end