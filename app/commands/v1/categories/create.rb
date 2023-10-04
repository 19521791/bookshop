class V1::Categories::Create
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    category = current_user.categories.new(params)
    category.save ? CategoryPresenter.new(category).json_response : category.errors
  end
end
