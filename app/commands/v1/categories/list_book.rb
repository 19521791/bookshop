class V1::Categories::ListBook
  prepend SimpleCommand
  attr_reader :params
  include Paginable

  def initialize(params)
    @params = params
  end

  def call
    category = Category.find_by(id: params[:id])
    return errors.add(:category, 'not found') unless category

    books = books_in_category(category)
    {
      category: CategoryPresenter.new(category).json_response,
      records: books.map { |book| BookCategoryPresenter.new(book).json_response },
      pagination: pagination(books)
    }
  end

  private

  def books_in_category(category)
    books = category.books.select(:id, :title, :author, :rating)
    books.page(page_params).per(per_page)
  end
end
