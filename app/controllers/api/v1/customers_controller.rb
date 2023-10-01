class Api::V1::CustomersController < ApplicationController
  include ApiResponse
  include UserParams
  include CheckRole
  skip_before_action :verify_authenticity_token
  before_action :check_role_customer, only: [:login, :register]

  def login
    command = V1::Users::Login.call(auth_params)
    handle_respone(command, 'login', 'Error when trying to login')
  end

  def register
    command = V1::Users::Register.call(user_params)
    handle_respone(command, 'register', 'Error when creating a new user')
  end

  def index
    render json: {
      message: 'customers'
    }
  end

  def show
    render json: {
      message: 'customers/:id'
    }
  end

  def destroy
    render json: {
      message: 'destroy'
    }
  end
end