class V1::Books::Update
  prepend SimpleCommand
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    book = Book.includes(:categories).find_by(id: book_id)

    return errors.add(:book, 'not found') unless book

    update_book_categories(book, book_params[:book_categories_attributes])

    # return book.errors unless book.update(book_params)

    BookPresenter.new(book).json_response
  end

  private

  def update_book_categories(book, book_categories_params)
    return nil unless book_categories_params.present?

    category_ids = Set.new
    unique_book_categories_params = []

    book_categories_params.each do |bc|
      category_id = bc[:category_id]

      if category_ids.include?(category_id)

        errors.add(:base, "Duplicate category_id #{category_id}")
      else
        category = Category.find_by(id: category_id)
        if category
          category_ids.add(category_id)
          unique_book_categories_params << bc
        else
          errors.add(:base, "Category with ID #{category_id} not found.")
        end
      end
    end

    book.book_categories.destroy_all
    book.book_categories.create(unique_book_categories_params)
  end

  def book_id
    params[:id]
  end

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
