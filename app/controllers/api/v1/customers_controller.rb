class Api::V1::CustomersController < ApplicationController

  include ApiResponse
  before_action :authenticate_customer, only: [:index, :show, :update, :destroy]
  
  # POST /api/v1/customers/login
  def login
    command = V1::Customers::Login.call(params)
    handle_respone(command, 'login', 'Error when trying to login')
  end

  # POST /api/v1/customers/register
  def create
    command = V1::Customers::Create.call(params)
    handle_respone(command, 'register', 'Error when creating a new customer')
  end

  # GET /api/v1/customers
  def index
    command = V1::Customers::List.call(params)
    handle_respone(command, 'list', 'Error when listing customers')
  end

  # GET /api/v1/customers/:id
  def show
    command = V1::Customers::Detail.call(params, current_user)
    handle_respone(command, 'detail', 'Error when fetching customer details')
  end

  # PUT /api/v1/customers/:id
  def update
    command = V1::Customers::Update.call(params, current_user)
    handle_respone(command, 'update', 'Error when updating the customer')
  end

  # DELETE /api/v1/customers/:id
  def destroy
    command = V1::Customers::Destroy.call(params, current_user)
    handle_respone(command, 'destroy', 'Error when deleting the customer ')
  end

end