class V1::Books::Update
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
    end
  
    def call
      book = Book.includes(:categories).find_by(id: book_id)

      return errors.add(:book, 'not found') unless book

      return book.errors unless book.update(book_params)
      
      update_book_categories(book, book_params[:book_categories_attributes])

      BookPresenter.new(book).json_response
    end

    private 

    def update_book_categories(book, book_categories_params)
      existing_category_ids = book.book_categories.pluck(:category_id)
    
      new_category_ids = book_categories_params.map { |bc| bc['category_id'].to_i }
    
      if existing_category_ids.sort == new_category_ids.sort
        return 
      end
    
      to_remove = existing_category_ids - new_category_ids
      to_add = new_category_ids - existing_category_ids
    
      book.book_categories.where(category_id: to_remove).destroy_all
    
      to_add.each do |category_id|
        book.book_categories.create(category_id: category_id)
      end
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
  