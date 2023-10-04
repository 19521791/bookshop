# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

# 10.times do
#   user = User.new(
#     name: Faker::Name.name,
#     firstname: Faker::Name.first_name,
#     lastname: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: '12345678',
#     role: Faker::Number.between(from: 0, to: 1),
#     mobile: '0123456789'
#   )

#   if user.valid?
#     user.save
#   else
#     puts "USer not saved due to validation errors: #{user.errors.full_messages}"
#   end
# end



# 10.times do
#   user_id = admin_users.sample
#   book = Book.create(
#     title: Faker::Book.title,
#     author: Faker::Book.author,
#     description: Faker::Lorem.paragraph,
#     thumbnail: Faker::Internet.url,
#     rating: Faker::Number.between(from: 1, to: 5).to_f,
#     price: Faker::Number.between(from: 10.0, to: 100.0).round(2),
#     stock: Faker::Boolean.boolean
#     user_id: user_id
#   )

#   category = Category.all.sample
#   BookCategory.create(book: book, category: category)

#   if Faker::Boolean.boolean
#     other_category = Category.all.sample
#     BookCategory.create(book: book, category: other_category)
#   end
# end
admin = User.find_by(role: "admin")
5.times do
  category = Category.new(
    name: Faker::Lorem.word,
    categorable_id: rand(1..10),
    categorable_type: "category",
    user_id: admin.id
  )

  if category.valid?
    category.save
  else
    puts "Category not saved due to validation errors: #{category.errors.full_messages}"
  end
end


 
