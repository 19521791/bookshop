class BaseBooksController < ApplicationController

  include ApiResponse
  include BaseParams
  skip_before_action :verify_authenticity_token
  before_action :authenticate, only: [:create, :update, :destroy]
  
  def index
    command = V1::Books::List.call(params)
    handle_respone(command, 'list', 'Error when listing books')
  end

  def show
    command = V1::Books::Detail.call(params)
    handle_respone(command, 'details', 'Error when fetching book details')
  end

  def create 
    command = V1::Books::Create.call(book_params, current_user)
    handle_respone(command, 'create', 'Error when creating a new book')
  end

  def update
    command = V1::Books::Update.call(book_params, params[:id])
    handle_respone(command, 'update', 'Error when updating the book')
  end

  def destroy
    command = V1::Books::Destroy.call(params[:id])
    handle_respone(command, 'destroy', 'Error when deleting the book')
  end
end