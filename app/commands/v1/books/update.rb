class V1::Books::Update
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
      @book_id = book_id
    end
  
    def call
      book = Book.includes(:categories).find_by(id: book_id)

      return errors.add(:book, 'not found') unless book

      return book.errors unless book.update(params)
      
      update_book_categories(book, params[:book_categories_attributes])

      BookPresenter.new(book).json_response
    end

    private 

    def update_book_categories(book, book_categories_params)
      book.book_categories.destroy_all
      book.update(book_categories_attributes: book_categories_params)
    end
    
    def book_id
      params[:id]
    end
      
  end
  