class V1::Categories::Update
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
    end
  
    def call
      category = Category.find_by(id: category_id)

      return errors.add(:category, 'not found') unless category

      return category.errors unless category.update(category_params)
      
      CategoryPresenter.new(category).json_response
    end

    private 

    def category_id
      params[:id]
    end

    def category_params
      params.permit(:name, sub_categories_attributes: [:id, :name])
    end
      
  end
  