class V1::Books::List
    prepend SimpleCommand
    attr_reader :params
    include Paginatable
    def initialize(params)
        @params = params
    end

    def call
        books = Book.ordered_by_created_at.search_params(keyword).includes(:categories).page(page_params).per(per_page)
        books.map { |book| BookPresenter.new(book).json_response }
    end

    private

    def keyword
        params[:keyword]
    end
end