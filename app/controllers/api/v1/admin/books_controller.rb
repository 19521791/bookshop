class Api::V1::Admin::BooksController < ApplicationController

  include ApiResponse
  before_action :show, only: %i(show)
  skip_before_action :verify_authenticity_token

  # Get /api/v1/admin/books
  def index
    page = params[:page] || 1
    command = V1::Books::List.call(page)
    books = command.result[:books]
    render json: {
      books: command.result,
      message: 'Books listed successfully'
    }, status: :ok
  end

  # Get /api/v1/admin/books/:id
  def show
    book_id = params[:id]
    command = V1::Books::Detail.call(book_id)
    handle_respone(command, 'details', 'Error when fetching book details')
  end

  # POST /api/v1/admin/create-book
  def create 
    command = V1::Books::Create.call(book_params)
    handle_respone(command, 'create', 'Error when creating a new book')
  end

  # PUT /api/v1/admin/books/:id
  def update
    command = V1::Books::Update.call(book_params, params[:id])
    handle_respone(command, 'update', 'Error when updating the book')
  end

  # DELETE /api/v1/admin/books/:id
  def destroy
    command = V1::Books::Destroy.call(params[:id])
    handle_respone(command, 'destroy', 'Error when deleting the book')
  end

  private 

  def book_params
    params.permit(
      :title,
      :author,
      :description,
      :thumbnail,
      :rating,
      :price,
      :stock,
      book_categories_attributes: [:id, :category_id, :_allow_destroy]
    )
  end  
end

