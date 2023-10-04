class Api::V1::CustomersController < BaseUsersController

  before_action :authenticate_customer, only: [:login, :update, :destroy]

  # POST /api/v1/customers/login
  def login
    super
  end

  # POST /api/v1/customers/register
  def create
    super
  end

  # GET /api/v1/customers
  def index
    super
  end

  # GET /api/v1/customers/:id
  def show
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