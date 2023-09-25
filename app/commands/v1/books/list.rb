class V1::Books::List
    prepend SimpleCommand

    def call
        books = Book.ordered_by_created_at.includes(:categories)
        books.map { |book| book_data(book) }
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