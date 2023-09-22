class V1::Books::Create
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
    end
  
    def call
      @book = Book.new(params)

      if @book.save
        @book
      else
        errors.add(:base, 'Error when creating a new book')
        errors.add(:details, @book.errors.full_messages.join(', '))
      end
    end
      
  end
  