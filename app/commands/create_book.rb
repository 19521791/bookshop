class CreateBook
    prepend SimpleCommand

    def initialize(params)
        @params = params
    end

    def call
        book_params = @params.except(:category_names)
        category_names = @params[:category_names]

        book = Book.new(book_params)

        if book.save
            category_names.each do |category_name|
                category = Category.find_or_create_by(name: category_name)
                BookCategory.create(book_id: book.id, category_id: category.id)
            end
            book
        else
            nil
        end
    end
end