class CategoryPresenter < BasePresenter
  attr_reader :category

  def initialize(category)
    @category = category
  end

  def json_response
    if category.categorable.nil?
      sub_categories = category.sub_categories.map do |sc|
        {
          id: sc.id,
          name: sc.name
        }
      end
    else
      sub_categories = []
    end

    {
      id: category.id,
      name: category.name,
      sub_categories: sub_categories
    }
  end
end
