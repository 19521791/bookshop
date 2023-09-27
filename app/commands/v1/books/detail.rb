class V1::Books::Detail
    prepend SimpleCommand
    attr_reader :book_id

    def initialize(params)
        @book_id = params[:book_id]
    end

    def call
        book = Book.includes(:categories).find_by(id: book_id)
        return errors.add(:book, 'not found') if book.nil?

        BookPresenter.new(book).response
    end
end