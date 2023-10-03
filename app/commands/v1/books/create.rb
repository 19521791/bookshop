class V1::Books::Create
  prepend SimpleCommand
  attr_reader :params, :current_user

  def initialize(params, current_user)
    @params = params
    @current_user = current_user
  end

  def call
    book = current_user.books.new(params)
    book.save ? BookPresenter.new(book).json_response : book.errors
  end
end
