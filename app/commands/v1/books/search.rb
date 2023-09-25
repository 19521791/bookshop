class V1::Books::Search
    prepend SimpleCommand
    attr_reader :params

    def initialize(params)
        @params = params
    end

    def call
        books = Book.ordered_by_created_at.includes(:categories)

        if params[:name].present?
            books = books.where("title = :query OR author = :query", query: params[:name])
            return books
        else
            nil
        end
    end
end