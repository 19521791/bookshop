class Api::V1::BooksController < ApplicationController
    before_action :show, only: %i(show)

    def index
        command = QueryBooks.call

        if command.success?
            render json: {
                status: true,
                data: command.result
            }, status: :ok
        else
            render json: {
                status: false,
                message: 'Error when querying the list of books'
            }, status: :unprocessable_entity

        end
    end

    def show
        book_id = params[:id]
        command = QueryBooks.call(book_id)

        if command.success?
            render json: {
              status: true,
              data: command.result
            }, status: :ok
          else
            render json: {
              status: false,
              message: 'Error when querying the book'
            }, status: :unprocessable_entity
        end
    end
end

