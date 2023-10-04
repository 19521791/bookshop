class Api::V1::Admin::BooksController < BaseBooksController

  before_action :authenticate_admin, only: [:create, :update, :destroy]

  # Get /api/v1/admin/books
  def index
    super
  end

  # Get /api/v1/admin/books/:id
  def show
    super
  end

  # POST /api/v1/admin/create-book
  def create 
    super
  end

  # PUT /api/v1/admin/books/:id
  def update
    super
  end

  # DELETE /api/v1/admin/books/:id
  def destroy
    super
  end

end

