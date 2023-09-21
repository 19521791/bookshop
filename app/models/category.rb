class Category < ApplicationRecord
    belongs_to :parent, :class_name => 'Category', optional: true
    has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
    has_many :book_category
    has_many :books, through: :book_category

    validates :name, presence: true, uniqueness: true
end
