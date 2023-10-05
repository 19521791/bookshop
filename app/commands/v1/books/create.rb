class V1::Books::Create
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    book = Book.new(book_params.merge(user_id: current_user.id))
    book.save ? BookPresenter.new(book).json_response : book.errors
  end

  private

  def book_params
    params.permit(
      :title,
      :author,
      :description,
      :thumbnail,
      :rating,
      :price,
      :stock,
      book_categories_attributes: [:id, :category_id, :_allow_destroy]
    )
  end
end
