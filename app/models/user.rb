# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  mobile     :string
#  name       :string
#  password   :string
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
    has_many :books
    has_many :categories
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
    validates :mobile, presence: true, format: { with: /\A\d{10}\z/ }
    validates :password, presence: true, length: { minimum: 8 }

    enum role: { customer: 0, admin: 1}
end
