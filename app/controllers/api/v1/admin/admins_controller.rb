class Api::V1::Admin::AdminsController < BaseUsersController

  before_action :authenticate_admin, only: %i[:login, :index, :show, :update, :destroy. :create]

  # POST /api/v1/admin/login
  def login
    super
  end

  # POST /api/v1/admin/register
  def create
    super
  end

  # GET /api/v1/admin
  def index
    super
  end

  # GET /api/v1/admin/:id
  def show
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