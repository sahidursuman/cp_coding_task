# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


require 'faker'
time_arr = [
  Time.now,
  Time.now - 10.days,
  Time.now - 2.days,
  Time.now - 3.days,
  Time.now - 7.days,
  Time.now - 15.days,
  Time.now - 12.days,
  Time.now - 13.days,
  Time.now - 21.days,
  Time.now - 25.days,
  Time.now - 29.days,
  Time.now - 30.days,
  Time.now - 9.days
]



user1 = User.create(
  name: 'Sahidur Rahman',
  email: 'suman5040@gmail.com'
)

r = Recipe.create(
  user: user1,
  country: 'UK',
  published_at: (Time.now - 2.days)
)

r = Recipe.create(
  user: user1,
  country: 'UK',
  published_at: (Time.now - 3.days)
)

user2 = User.create(
  name: 'Jumara Begum',
  email: 'dr.jumara@gmail.com'
)

r = Recipe.create(
  user: user2,
  country: 'UK',
  published_at: (Time.now - 3.days)
)

user3 = User.create(
  name: 'Nusaiba Sahid',
  email: 'nusaiba@gmail.com'
)

r = Recipe.create(
  user: user3,
  country: 'UK',
  published_at: (Time.now - 5.days)
)

user4 = User.create(
  name: 'Jawad Sahid',
  email: 'jawad@gmail.com'
)

r = Recipe.create(
  user: user4,
  country: 'UK',
  published_at: (Time.now + 5.days)
)

