# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  categorable_type :string
#  name             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  categorable_id   :integer
#
class Category < ApplicationRecord  
    belongs_to :user, optional: true
    belongs_to :categorable, polymorphic: true, optional: true
    has_many :sub_categories, as: :categorable, class_name: 'Category', dependent: :destroy
    has_many :book_categories
    has_many :books, through: :book_categories
    accepts_nested_attributes_for :sub_categories, allow_destroy: true
    validates :name, presence: true, uniqueness: true

    scope :search_params, -> (keyword) {
        if keyword.present?
            keyword.split(',').reduce(all) do |query, key|
                query.where("name LIKE :key ", key: "%#{key}%")
            end 
        else
            all
        end
    }

    scope :order_by_fields, ->(order_fields, order_by) {
        if order_fields.present?
            order_params = order_fields.map do |order_field|
                direction = order_by == 'asc' ? 'asc' : 'desc'
                "#{order_field} #{direction}"
            end
            order(order_params.join(', '))
        else
            order(created_at: :desc)
        end
    }

    scope :with_books_by_id_or_name, ->(category_id_or_name) {
        where(id: category_id_or_name)
        .or(where(name: category_id_or_name))
        .includes(books: :categories)
    }

    scope :with_books_info, -> { includes(books: { only: [:title, :author, :rating] }) }
end
