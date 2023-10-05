class BaseUsersController < ApplicationController

  include ApiResponse
    
  def login
    command = V1::Users::Login.call(params)
    handle_respone(command, 'login', 'Error when trying to login')
  end

  def create
    command = V1::Users::Create.call(params)
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
