class Api::V1::CustomersController < BaseUsersController

  include CheckRole
  before_action :check_role_customer, only: [:register]

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
    # enum role: { customer: 0, admin: 1}
    params[:role] = "customers"
    super
  end

  # GET /api/v1/customers/:id
  def show
    # enum role: { customer: 0, admin: 1}
    params[:role] = "customers"
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