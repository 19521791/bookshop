class QueryBooks
    prepend SimpleCommand

    def initialize(book_id=nil)
        @book_id = book_id
    end
  
    def call
        if @book_id
          book = Book.find_by(id: @book_id)
          if book
            {
              id: book.id,
              title: book.title,
              author: book.author,
              description: book.description,
              thumbnail: book.thumbnail,
              rating: book.rating,
              price: book.price,
              stock: book.stock,
              categories: book.categories.pluck(:name)
            }
          else
            nil 
          end
        else
          books = Book.order('created_at DESC')
          books.map do |book|
            {
              id: book.id,
              title: book.title,
              author: book.author,
              description: book.description,
              thumbnail: book.thumbnail,
              rating: book.rating,
              price: book.price,
              stock: book.stock,
              categories: book.categories.pluck(:name)
            }
          end
        end
    end
  end