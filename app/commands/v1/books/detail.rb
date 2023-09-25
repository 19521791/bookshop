class V1::Books::Detail
    prepend SimpleCommand
    attr_reader :book_id

    def initialize(book_id)
        @book_id = book_id
    end

    def call
        book = Book.includes(:categories).find_by(id: book_id)
        return nil unless book

        book_data(book)
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