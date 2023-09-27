class V1::Books::List
    prepend SimpleCommand
    attr_reader :params
    include Paginatable
    def initialize(params)
        @params = params
    end

    def call
        if keyword
            books = Book.ordered_by_created_at.includes(:categories)
            books = books.search_params(keyword)
        else
            books = Book.ordered_by_created_at.includes(:categories).page(page_params).per(per_page)
        end
        books.map { |book| BookPresenter.new(book).response }
    end

    private

    def keyword
        params[:key]
    end
end