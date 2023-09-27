class V1::Books::Destroy
    prepend SimpleCommand
    attr_reader :book_id
  
    def initialize(book_id)
      @book_id = book_id
    end
  
    def call
        book = Book.includes(:categories).find_by(id: book_id)
        book ? book.destroy : errors.add(:book, 'not found')
    end
  end
  