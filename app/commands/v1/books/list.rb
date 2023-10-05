class V1::Books::List
    prepend SimpleCommand
    attr_reader :params
    include Paginable
    def initialize(params)
        @params = params
    end

    def call
    {
        records: books.map { |book| BookPresenter.new(book).json_response },
        pagination: pagination(books)
    }
    end

    private

    def books
        books ||= Book.includes(:categories)
                    .search_params(keyword)
                    .order_by_fields(order_params, order_by)
                    .page(page_params)
                    .per(per_page)
    end

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