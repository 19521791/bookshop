class V1::Categoriess::Destroy
    prepend SimpleCommand
    attr_reader :params
  
    def initialize(params)
      @params = params
    end
  
    def call
        category = Category.find_by(id: category_id)
        category ? category.destroy : errors.add(:category, 'not found')
    end

    private

    def category_id
      params[:id]
    end
  end
  