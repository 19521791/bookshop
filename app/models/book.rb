class Book < ApplicationRecord
    belongs_to :user, optional: true
    has_many :book_category
    has_many :categories, through: :book_category
end
