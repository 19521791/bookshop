class Api::V1::BooksController < ApplicationController

    include ApiResponse
    before_action :show, only: %i(show)
    skip_before_action :verify_authenticity_token
    
    # GET /api/v1/books
    def index
        command = V1::Books::List.call(params)
        books = command.result[:books]
        render json: {
        books: command.result,
        message: 'Books listed successfully'
        }, status: :ok
    end
  
    # GET /api/v1/books/:id
    def show
        command = V1::Books::Detail.call(params)
        handle_respone(command, 'details', 'Error when fetching book details')
    end

    # GET /api/v1/books/search?type=:type&value=:value
    def search
        type = params[:type]
        value = params[:value]

        command = V1::Books::Search.call(type, value)
        handle_respone(command, 'search', 'Error when searching the book')
    end
end
  
  