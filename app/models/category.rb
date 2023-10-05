# == Schema Information
#
# Table name: categories
#
#  id               :bigint           not null, primary key
#  categorable_type :string
#  name             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  categorable_id   :integer
#  user_id          :bigint           not null
#
# Indexes
#
#  index_categories_on_user_id  (user_id)
#
class Category < ApplicationRecord  
    belongs_to :user, optional: true
    belongs_to :categorable, polymorphic: true, optional: true
    has_many :categories, as: :categorable, class_name: 'Category', dependent: :destroy
    has_many :book_categories
    has_many :books, through: :book_categories
    accepts_nested_attributes_for :categories

    validates :name, presence: true, uniqueness: true
end
