class Book < ApplicationRecord
    belongs_to :user, optional: true
    has_many :book_category
    has_many :categories, through: :book_category

    validates :title, presence: true
    validates :author, presence: true
    validates :description, presence: true
    validates :thumbnail, presence: true, format: { with: URI.regexp }, if: :thumbnail?
    validates :rating, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
    validates :price, numericality: { greater_than_or_equal_to: 0.0, less_than_or_equal_to: 100.0 }
end
