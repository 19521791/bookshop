class V1::Books::Create
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    book = Book.new(params)
    book.save ? BookPresenter.new(book).json_response : book.errors
  end
end
