class Api::V1::BooksController < ApplicationController

    include ApiResponse
    before_action :show, only: %i(show)
    skip_before_action :verify_authenticity_token
    
    # GET /api/v1/books
    def index
        command = V1::Books::List.call(params)
        handle_respone(command, 'list', 'Error when listing books')
    end
  
    # GET /api/v1/books/:id
    def show
        command = V1::Books::Detail.call(params)
        handle_respone(command, 'details', 'Error when fetching book details')
    end

end
  
  