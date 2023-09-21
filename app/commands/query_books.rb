class QueryBooks
  prepend SimpleCommand

  def initialize(book_id = nil)
    @book_id = book_id
  end

  def call
    if @book_id
      book = Book.find_by(id: @book_id)
      return nil unless book

      book_data(book)
    else
      books = Book.order('created_at DESC')
      books.map { |book| book_data(book) }
    end
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
