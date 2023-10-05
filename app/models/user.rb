# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string
#  firstname       :string
#  lastname        :string
#  mobile          :string
#  name            :string
#  password_digest :string
#  role            :integer          default("customer"), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_many :books
    has_many :categories
    has_secure_password
    validates :firstname, presence: true, format: { with: /\A[a-zA-Z]+\z/i, message: 'Invalid characters in firstname' }
    validates :lastname, presence: true, format: { with: /\A[a-zA-Z]+\z/, message: 'Invalid characters in lastname' }
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
    validates :mobile, presence: true, format: { with: /\A\d{10}\z/ }
    validates :password, presence: false

    enum role: { customer: 0, admin: 1}

    scope :search_params, -> (keyword) {
    query = if keyword.present?
      keyword.split(',').reduce(all) do |query, key|
        query.where("firstname LIKE :key OR lastname LIKE :key", key: "%#{key}%")
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

  scope :filtered_role, ->(flag) { where( role: flag == 'admin' ? 'admin' : 'customer')}
end
