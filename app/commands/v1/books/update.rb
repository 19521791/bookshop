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
        update_book_categories(book, params[:book_categories_attributes])
        return book
      else
        return book.errors
      end
    end

    private 

    def update_book_categories(book, book_categories_params)
        existing_category_ids = book.book_categories.map(&:category_id)
      
        new_category_ids = book_categories_params.map { |bc| bc['category_id'].to_i }
      
        categories_to_remove = existing_category_ids - new_category_ids
      
        book.book_categories.where(category_id: categories_to_remove).destroy_all
      
        new_category_ids.each do |category_id|
          book.book_categories.find_or_create_by(category_id: category_id)
        end
    end
      
  end
  