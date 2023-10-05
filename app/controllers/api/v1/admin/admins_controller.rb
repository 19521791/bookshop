class Api::V1::Admin::AdminsController < ApplicationController
  
  include ApiResponse
  before_action :authenticate_admin, only: [:show, :update, :destroy, :index, :create]

  # POST /api/v1/admin/login
  def login
    command = V1::Admins::Login.call(params)
    handle_respone(command, 'login', 'Error when trying to login')
  end

  # POST /api/v1/admin/register
  def create
    command = V1::Admins::Create.call(params)
    handle_respone(command, 'register', 'Error when creating a new admin')
  end

  # GET /api/v1/admin
  def index
    command = V1::Admins::List.call(params)
    handle_respone(command, 'list', 'Error when listing admins')
  end

  # GET /api/v1/admin/:id
  def show
    command = V1::Admins::Detail.call(params, current_user)
    handle_respone(command, 'detail', 'Error when fetching admin details')
  end

  # PUT /api/v1/admin/:id
  def update
    command = V1::Admins::Update.call(params, current_user)
    handle_respone(command, 'update', 'Error when updating the admin')
  end

  # DELETE /api/v1/admin/:id
  def destroy
    command = V1::Admins::Destroy.call(params, current_user)
    handle_respone(command, 'destroy', 'Error when deleting the admin ')
  end
end