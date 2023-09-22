# == Schema Information
#
# Table name: book_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  book_id     :bigint           not null
#  category_id :bigint           not null
#
# Indexes
#
#  index_book_categories_on_book_id      (book_id)
#  index_book_categories_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (book_id => books.id)
#  fk_rails_...  (category_id => categories.id)
#
require "test_helper"

class BookCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
