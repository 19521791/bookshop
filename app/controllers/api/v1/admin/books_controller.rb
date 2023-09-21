class Api::V1::Admin::BooksController < ApplicationController
    before_action :show, only: %i(show)
    skip_before_action :verify_authenticity_token

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

    def create 
        command = CreateBook.call(book_params)

        if command.success?
            render json: {
              status: true,
              data: command.result
            }, status: :created
          else
            render json: {
              status: false,
              message: 'Error when creating a new book',
              errors: command.errors.full_messages
            }, status: :unprocessable_entity
        end
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
            category_names: [] 
        )
    end
end

