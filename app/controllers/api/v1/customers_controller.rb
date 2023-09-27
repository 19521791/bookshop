class Api::V1::CustomersController < ApplicationController
    def index
        command = V1::Users::Register.call
        render json: {
            message: command.result
        }
    end

    def create
        command = V1::Users::Register.call(user_params)
    end

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
