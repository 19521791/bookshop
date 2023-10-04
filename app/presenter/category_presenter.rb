class CategoryPresenter < BasePresenter
  attr_reader :book
  def initialize(category)
      @category = category
  end

  def json_response
  {
    id: category.id,
    name: category.name      
  }
  end
end

