class CategoryPresenter < BasePresenter
  attr_reader :category
  def initialize(category)
      @category = category
  end

  def json_response
    {
      id: category.id,
      name: category.name,
      children: category.categories.map do |child|
        CategoryPresenter.new(child).json_response
      end
    }
  end
end