class V1::Books::Destroy
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
    end
  
    def call
        book = Book.find_by(id: book_id)
        book ? book.destroy : errors.add(:book, 'not found')
    end

    private

    def book_id
      params[:id]
    end
  end
  