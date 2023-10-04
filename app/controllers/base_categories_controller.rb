class BaseCategoriesController < ApplicationController

  include ApiResponse
  include BaseParams

  def index
    command = V1::Categories::List.call(params)
    handle_respone(command, 'list', 'Error when listing categories')
  end

  def show
    command = V1::Categories::Detail.call(params)
    handle_respone(command, 'details', 'Error when fetching category details')
  end

  def create 
    command = V1::Categories::Create.call(category_params, current_user)
    handle_respone(command, 'create', 'Error when creating a new category')
  end

  def update
    command = V1::Categories::Update.call(category_params, params[:id])
    handle_respone(command, 'update', 'Error when updating the category')
  end

  def destroy
    command = V1::Categories::Destroy.call(params[:id])
    handle_respone(command, 'destroy', 'Error when deleting the category')
  end
end