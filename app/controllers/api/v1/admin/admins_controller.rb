class Api::V1::Admin::AdminsController < BaseUsersController

  include CheckRole
  before_action :check_role_admin, only: [:register, :login]

  # POST /api/v1/admin/login
  def login
    super
  end

  # POST /api/v1/admin/register
  def register
    super
  end

  # GET /api/v1/admin
  def index
    params[:flag] = 1
    super
  end

  # GET /api/v1/admin/:id
  def show
    params[:flag] = 1
    super
  end

  # PUT /api/v1/admin/:id
  def update
    super
  end

  # DELETE /api/v1/admin/:id
  def destroy
    super
  end
end