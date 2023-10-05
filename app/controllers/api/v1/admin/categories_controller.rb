class Api::V1::Admin::CategoriesController < BaseCategoriesController

  before_action :authenticate_admin, only: [:create, :update, :destroy]

  # Get /api/v1/admin/categories
  def index
    super
  end

  # Get /api/v1/admin/categories/:id
  def show
    super
  end

  # POST /api/v1/admin/create-category
  def create 
    super
  end

  # PUT /api/v1/admin/categories/:id
  def update
    super
  end

  # DELETE /api/v1/admin/categories/:id
  def destroy
    super
  end

end

