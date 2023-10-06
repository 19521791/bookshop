class BookCategoryPresenter < BasePresenter
  attr_reader :book
  def initialize(book)
      @book = book
  end

  def json_response
  {
      title: book.title,
      author: book.author,
      rating: book.rating,
  }
  end
end

