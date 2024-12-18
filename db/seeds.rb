# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
5.times do |n|
  User.create!(
    name: "テスト太郎#{n}",
    age: n,
    gender: 1,
    email: "test#{n}@example.com",
    password: "password",
  )
end

5.times do |n|
  Genre.create!(
    mane: "スポーツ#{n}"
  )
end

5.times
Subgenre
