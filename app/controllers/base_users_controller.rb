class BaseUsersController < ApplicationController

  include ApiResponse
  include BaseParams
  
  skip_before_action :verify_authenticity_token
  before_action :authenticate, only: [:index, :show, :update, :destroy]
  
  def login
    command = V1::Users::Login.call(auth_params)
    handle_respone(command, 'login', 'Error when trying to login')
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
