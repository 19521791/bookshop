# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author      :string
#  description :text
#  price       :decimal(, )
#  rating      :float
#  stock       :boolean
#  thumbnail   :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Book < ApplicationRecord
    belongs_to :user, optional: true
    has_many :book_categories, dependent: :destroy
    has_many :categories, through: :book_categories
    accepts_nested_attributes_for :book_categories, allow_destroy: true

    scope :ordered_by_created_at, -> { order(created_at: :desc)}
    scope :search_by_query, ->(query) {
    where("title LIKE :query OR author LIKE :query OR EXISTS (SELECT 1 FROM categories WHERE categories.id = books.category_id AND categories.name LIKE :query)", query: "%#{query}")
    }

end
