class V1::Books::Search
    prepend SimpleCommand
    attr_reader :type, :value

    def initialize(type, value)
        @type = type
        @value = value
    end

    def call
        books = Book.ordered_by_created_at.includes(:categories)

        if value.present?
            books = books.search_by(type, value)
            return books
        else
            return errors.add(:book, 'not found') if books.nil?
        end
    end

    def type
    end
end