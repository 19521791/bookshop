class V1::Books::List
    prepend SimpleCommand
    attr_reader :params
    include Paginable
    def initialize(params)
        @params = params
    end

    def call
        books = Book.includes(:categories)
                    .order_by_fields(order_params, order_by)
                    .search_params(keyword)
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

    def order_params
        params[:order].present? ? params[:order].split(',') : []
    end

    def order_by
        params[:order_by].to_s.downcase
    end
end