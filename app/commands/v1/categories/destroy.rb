class V1::Categories::Destroy
    prepend SimpleCommand
    attr_reader :category_id
  
    def initialize(category_id)
      @category_id = category_id
    end
  
    def call
        category = Category.find_by(id: category_id)
        category ? category.destroy : errors.add(:category, 'not found')
    end
  end
  