class V1::Books::List
    prepend SimpleCommand
    attr_reader :page

    def initialize(params)
        @page = params.delete(:page)
    end

    def call
        books = Book.ordered_by_created_at.includes(:categories)
        pagy = Pagy.new(count: books.count, items: per_page, page: page)
        books = books.limit(pagy.items).offset(pagy.offset)
        {
            books: books.map { |book| BookPresenter.new(book).response },
            pagy: pagy
        }
    end

    def per_page
        items_per_page = 10
    end
end