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
    # enum role: { customer: 0, admin: 1}
    params[:role] = 1
    super
  end

  # GET /api/v1/admin/:id
  def show
    # enum role: { customer: 0, admin: 1}
    params[:role] = "admin"
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