# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'benchmark'
posts = []
comments = []
elapsed = Benchmark.measure do
  user =  User.create!(email: "user@blog.com",
                                password: "password",
                                password_confirmation: "password",
                                role: User.roles["user"],
                                first_name: "Demo",
                                last_name: "User")
  Address.find_or_create_by!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_pin: Faker::Address.postcode,
    country: Faker::Address.country,
    user: user
  )

  admin =  User.create(email: "admin@blog.com",
                                 password: "password",
                                 password_confirmation: "password",
                                 role: User.roles["admin"],
                                 first_name: "Demo",
                                 last_name: "Admin"
                                )
  Address.find_or_create_by!(
                            street: Faker::Address.street_address,
                            city: Faker::Address.city,
                            state: Faker::Address.state,
                            zip_pin: Faker::Address.postcode,
                            country: Faker::Address.country,
                            user: admin
                          )
  category = Category.find_or_create_by!(name: "Uncategorized", display_in_nav: true)
  Category.find_or_create_by!(name: "Cars", display_in_nav: false)
  Category.find_or_create_by!(name: "Bikes", display_in_nav: true)
  Category.find_or_create_by!(name: "Boats", display_in_nav: true)
  User.pluck(:id).each do |user_id|
    10.times {
      post = Post.new(
              title: "#{Faker::Dessert.variety} #{rand}",
              description: Faker::Lorem.paragraph,
              user_id: user_id,
              category: category
            )
      posts << post
      puts "#{post.title} is created!"
      2.times{
        comment = Comment.new(
          body: Faker::Lorem.paragraph,
          post_id: post.id,
          user_id: user_id
        )
        comments << comment
        puts "#{post.title} has comment #{comment.body.to_plain_text}!"
      }
    }
  end
  Post.import(posts)
  Comment.import(comments)
end
puts "-------------"
puts "-------------"
puts "-------------"

puts "Real time is #{elapsed.real}"

puts "-------------"
puts "-------------"
puts "-------------"