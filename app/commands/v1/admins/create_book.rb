class V1::Admins::CreateBook
    prepend SimpleCommand
    attr_reader :params

    def initialize(params)
        @params = params
    end

    def call
        book_params = params.except(:category_names)
        category_names = params[:category_names]

        book = Book.new(book_params)

        if book.save
            book.update(book_category_attributes(category_names))
            book
        else
            nil
        end
    end

    private

    def book_category_attributes(category_names)
        categories_attributes = category_names.map do |category_name|
            { category_attributes: { name: category_name }}
        end
        { book_category_attributes: categories_attributes }
    end
end