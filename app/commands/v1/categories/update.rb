class V1::Categories::Update
    prepend SimpleCommand
    attr_reader :params, :category_id
  
    def initialize(params, category_id)
      @params = params
      @category_id = category_id
    end
  
    def call
      # category = Category.find_by(id: category_id)

      # return errors.add(:category, 'not found') unless category

      # return category.errors unless category.update(params)
      
      # update_book_categories(category, params[:book_categories_attributes])

      # CategoryPresenter.new(category).json_response
    end

    # private 

    # def update_book_categories(category, book_categories_params)
    #   category.book_categories.destroy_all
    #   category.update(book_categories_attributes: book_categories_params)
    # end
    
      
  end
  