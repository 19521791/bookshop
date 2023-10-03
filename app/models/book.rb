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
#  user_id     :bigint           not null
#
# Indexes
#
#  index_books_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Book < ApplicationRecord
  belongs_to :user, optional: true
  has_many :book_categories, dependent: :destroy
  has_many :categories, through: :book_categories
  accepts_nested_attributes_for :book_categories, allow_destroy: true
  
  scope :search_params, -> (keyword) {
    if keyword.present?
      keyword.split(',').reduce(all) do |query, key|
        query.where("title LIKE :key OR author LIKE :key OR categories.name LIKE :key", key: "%#{key}%")
            .joins(:categories)
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

end
