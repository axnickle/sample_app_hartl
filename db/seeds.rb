# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seeding the database with sample users

# Create a main sample user.
User.create!(name:  "Anna N",
             email: "anickle@covermymeds.com",
             password:              "supercool",
             password_confirmation: "supercool",
             admin:     true,
             activated: true,
             activated_at: Time.zone.now)
             
User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "123456",
             password_confirmation: "123456")

# Generate a bunch of additional users.
99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

#in rails console --sandbox run the following commands
    #user = User.first
    #user.admin?
    #user.toggle!(:admin)
    #user.admin?
