class CreateBook
    prepend SimpleCommand

    def initialize(params)
        @params = params
    end

    def call
        book = Book.new(
            title: @params[:title],
            author: @params[:author],
            description: @params[:description],
            thumbnail: @params[:thumbnail],
            rating: @params[:rating],
            price: @params[:price],
            stock: @params[:stock]
        )

        if book.save
            @params[:category_names].each do |category_name|
                category = Category.find_or_create_by(name: category_name)
                BookCategory.create(book_id: book.id, category_id: category.id)
            end
            book
        else
            nil
        end
    end
end