# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
class Category < ApplicationRecord
    belongs_to :parent, :class_name => 'Category', optional: true
    has_many :children, :class_name => 'Category', :foreign_key => 'parent_id'
    has_many :book_categories
    has_many :books, through: :book_categories

    validates :name, presence: true, uniqueness: true
end
