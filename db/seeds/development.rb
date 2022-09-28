# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'faker'
require 'benchmark'
posts = []
comments = []
elapsed = Benchmark.measure do
  user =  User.first_or_create!(email: "user@blog.com",
                                password: "password",
                                role: User.roles["user"],
                                first_name: "Demo",
                                last_name: "User")
  Address.first_or_create!(
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    zip_pin: Faker::Address.postcode,
    country: Faker::Address.country,
    user: user
  )

  admin =  User.first_or_create!(email: "user@blog.com",
                                 password: "password",
                                 role: User.roles["admin"],
                                 first_name: "Demo",
                                 last_name: "Admin"
                                )
  Address.first_or_create!(
                            street: Faker::Address.street_address,
                            city: Faker::Address.city,
                            state: Faker::Address.state,
                            zip_pin: Faker::Address.postcode,
                            country: Faker::Address.country,
                            user: admin
                          )
  User.pluck(:id).each do |user_id|
    10.times {
      post = Post.new(
              title: "#{Faker::Dessert.variety} #{rand}",
              description: Faker::Lorem.paragraph,
              user_id: user_id
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