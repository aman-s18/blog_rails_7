# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'benchmark'
posts = []
comments = []
elapsed = Benchmark.measure do
  # 2.times {
    User.create(
      email: "#{Faker::Name.first_name.downcase}@blog.com",
      password: 123456, role: User.roles["user"],
      name: "#{Faker::Name.name}"
    )
    # puts "#{user.name} is created with role #{user.role}"
  # }

  # 2.times {
    User.create(
      email: "#{Faker::Name.first_name.downcase}@blog.com",
      password: 123456, role: User.roles["admin"],
      name: "#{Faker::Name.name}"
    )
    # puts "#{user.name} is created with role #{user.role}"

  # }

  User.pluck(:id).each do |user_id|
  400.times {
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
puts "             "
puts "             "
puts "             "
puts "Real time is #{elapsed.real}"