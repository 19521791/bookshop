class V1::Books::Create
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    book = Book.new(params)

    if book.save
      return book
    else
      return book.errors
    end
  end
end
