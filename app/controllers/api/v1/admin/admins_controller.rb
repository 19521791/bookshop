class Api::V1::Admin::AdminsController < ApplicationController

  include ApiResponse
  include UserParams
  skip_before_action :verify_authenticity_token

  def login
    render json: {
      message: 'login'
    }
  end

  def register
    command = V1::Users::Register.call(user_params)
    handle_respone(command, 'register', 'Error when creating a new user')
  end

  def index
    command = V1::Users::List.call(params)
    handle_respone(command, 'list', 'Error when listing users')
  end

  def show
    render json: {
      message: 'customers/:id'
    }
  end

  def update
    render json: {
      message: 'update'
    }
  end

  def destroy
    render json: {
      message: 'destroy'
    }
  end
end