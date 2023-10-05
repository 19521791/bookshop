class CategoryPresenter < BasePresenter
  attr_reader :category
  def initialize(category)
      @category = category
  end

  def json_response
  {
      id: category.id,
      name: category.name,
      sub_categories: category.sub_categories.pluck(:id, :name)
  }
  end
end