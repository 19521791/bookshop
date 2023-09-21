class User < ApplicationRecord
    has_many :books
    has_many :categories

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/ }
    validates :mobile, presence: true, format: { with: /\A\d{10}\z/ }
    validates :password, presence: true, length: { minimum: 8 }
end
