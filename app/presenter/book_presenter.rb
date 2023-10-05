class BookPresenter < BasePresenter
    attr_reader :book
    def initialize(book)
        @book = book
    end

    def json_response
    {
        id: book.id,
        title: book.title,
        author: book.author,
        description: book.description,
        thumbnail: book.thumbnail,
        rating: book.rating,
        price: book.price,
        stock: book.stock,
        categories: book.categories.pluck(:id, :name)
    }
    end
end

