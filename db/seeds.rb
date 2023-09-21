# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

10.times do
    User.create(
      name: Faker::Name.name,
      password: 'password',
      role: Faker::Lorem.word,  
      email: Faker::Internet.email,
      mobile: Faker::PhoneNumber.cell_phone
    )
  end

  10.times do
    book = Book.create(
      title: Faker::Book.title,
      author: Faker::Book.author,
      description: Faker::Lorem.paragraph,
      thumbnail: Faker::Internet.url,
      rating: Faker::Number.between(from: 1, to: 5).to_f,
      price: Faker::Number.between(from: 10.0, to: 100.0).round(2),
      stock: Faker::Boolean.boolean
    )
  
    # Ensure each book has at least one category
    category = Category.all.sample
    BookCategory.create(book: book, category: category)
  
    # Add an additional category for some books (50% chance)
    if Faker::Boolean.boolean
      other_category = Category.all.sample
      BookCategory.create(book: book, category: other_category)
    end
  end


  # categories = [
  #   'Fiction',
  #   'Non-Fiction',
  #   'Science Fiction',
  #   'Mystery',
  #   'Fantasy',
  #   'Romance',
  #   'Self-Help',
  #   'Biography',
  #   'History',
  #   'Cooking',
  # ]

  # categories.each do |category_name|
  #   Category.create(name: category_name)
  # end
