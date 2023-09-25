class Api::V1::BooksController < ApplicationController

    include ApiResponse
    before_action :show, only: %i(show)
    skip_before_action :verify_authenticity_token
  
    def index
        page = params[:page] || 1
        command = V1::Books::List.call(page)
        books = command.result[:books]
        render json: {
        books: command.result,
        message: 'Books listed successfully'
        }, status: :ok
    end
  
    def show
        book_id = params[:id]
        command = V1::Books::Detail.call(book_id)
        handle_respone(command, 'details', 'Error when fetching book details')
    end

    def search
        command = V1::Books::Search.call(params)
        handle_respone(command, 'search', 'Error when searching the book')
    end
end
  
  