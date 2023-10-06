class CategoryPresenter < BasePresenter
  attr_reader :category

  def initialize(category)
    @category = category
  end

  def json_response
    sub_categories = []
    if category.sub_categories.present?
      sub_categories = category.sub_categories.map do |sc|
        {
          id: sc.id,
          name: sc.name
        }
      end
    end

    {
      id: category.id,
      name: category.name,
      sub_categories: sub_categories
    }
  end
end
