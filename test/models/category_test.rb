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
require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
