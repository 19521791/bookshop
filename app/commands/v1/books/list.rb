class V1::Books::List
    prepend SimpleCommand
    attr_reader :params
    include Paginable
    def initialize(params)
        @params = params
    end

    def call
        books = Book.includes(:categories)
                    .search_params(keyword)
                    .ordered_by_created_at
                    .page(page_params)
                    .per(per_page)
        {
            records: books.map { |book| BookPresenter.new(book).json_response },
            pagy: pagination(books)
        }
    end

    private

    def keyword
        params[:keyword]
    end
end