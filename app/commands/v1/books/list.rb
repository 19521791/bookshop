class V1::Books::List
    prepend SimpleCommand
    attr_reader :page, :items_per_page

    def initialize(page, items_per_page=10)
        @page = page
        @items_per_page = items_per_page
    end

    def call
        books = Book.ordered_by_created_at.includes(:categories)
        pagy = Pagy.new(count: books.count, items: items_per_page, page: page)
        books = books.limit(pagy.items).offset(pagy.offset)
        {
            books: books.map { |book| book_data(book) },
            pagy: pagy
        }
    end

    private

    def book_data(book)
        {
          id: book.id,
          title: book.title,
          author: book.author,
          description: book.description,
          thumbnail: book.thumbnail,
          rating: book.rating,
          price: book.price,
          stock: book.stock,
          categories: book.categories.pluck(:name)
        }
    end
end