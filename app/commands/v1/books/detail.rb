class V1::Books::Detail
    prepend SimpleCommand
    attr_reader :params

    def initialize(params)
        @params = params
    end

    def call
        book = Book.includes(:categories).find_by(id: book_id)
        return errors.add(:book, 'not found') if book.nil?
        BookPresenter.new(book).json_response
    end

    private

    def book_id
        params[:id]
    end
end