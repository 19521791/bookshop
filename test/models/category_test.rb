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
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
