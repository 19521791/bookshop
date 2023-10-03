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
#  parent_id        :integer
#
class Category < ApplicationRecord  
    belongs_to :categorable, polymorphic: true
    has_many :sub_categories, as: :categorable, class_name: 'Category', dependent: :destroy
    has_many :book_categories
    has_many :books, through: :book_categories

    validates :name, presence: true, uniqueness: true
end
