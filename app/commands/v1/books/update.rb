class V1::Books::Update
    prepend SimpleCommand
    attr_reader :params, :book_id
  
    def initialize(params, book_id)
      @params = params
      @book_id = book_id
    end
  
    def call
        book = Book.includes(:categories).find_by(id: book_id)
      if book.update(params)
        return book
      else
        return book.errors
      end
    end
  end
  