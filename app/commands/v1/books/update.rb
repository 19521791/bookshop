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

      return book.errors unless book.update(book_params)
      
      # update_book_categories(book, params[:book_categories_attributes])

      BookPresenter.new(book).json_response
    end

    private 

    def update_book_categories(book, book_categories_params)
      book.book_categories.destroy_all
      book.update(book_categories_attributes: params.permit(book_categories_attributes: [:id, :category_id, :_allow_destroy]))
    end
    
    def book_id
      params[:id]
    end


    def book_params
      params.permit(
        :title,
        :author,
        :description,
        :thumbnail,
        :rating,
        :price,
        :stock,
        book_categories_attributes: [:id, :category_id, :_allow_destroy]
      )
    end
      
  end
  