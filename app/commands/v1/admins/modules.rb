module V1
    module Admins
        module Modules
            def create_book
                @create_book ||= CreateBook
            end

            def query_books
                @query_books ||= QueryBooks
            end
        end
    end
end