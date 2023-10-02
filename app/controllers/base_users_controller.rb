class BaseUsersController < ApplicationController

  include ApiResponse
  include BaseParams
  
  skip_before_action :verify_authenticity_token
  before_action :authenticate, only: [:show, :update, :destroy]
  
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
    command = V1::Users::Detail.call(params, current_user)
    handle_respone(command, 'detail', 'Error when fetching user details')
  end

  def update
    command = V1::Users::Update.call(params, current_user)
    handle_respone(command, 'update', 'Error when updating the user')
  end

  def destroy
    command = V1::Users::Destroy.call(params, current_user)
    handle_respone(command, 'destroy', 'Error when deleting the user ')
  end
end
