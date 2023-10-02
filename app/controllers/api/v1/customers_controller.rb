class Api::V1::CustomersController < BaseUsersController

  include CheckRole
  before_action :check_role_customer, only: [:register, :login]

  # POST /api/v1/customers/login
  def login
    super
  end

  # POST /api/v1/customers/register
  def register
    super
  end

  # GET /api/v1/customers
  def index
    params[:flag] = 0
    super
  end

  # GET /api/v1/customers/:id
  def show
    params[:flag] = 0
    super
  end

  # PUT /api/v1/customers/:id
  def update
    super
  end

  # DELETE /api/v1/customers/:id
  def destroy
    super
  end
end