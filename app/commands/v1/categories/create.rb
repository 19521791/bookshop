class V1::Categories::Create
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    category = Category.new(category_params)
    category.save ? CategoryPresenter.new(category).json_response : category.errors
  end

  private

  def category_params
    params.permit(
      :name,
      sub_categories_attributes: [:id, :name, :allow_destroy]
    )
  end
end
