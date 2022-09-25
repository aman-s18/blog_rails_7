# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
puts 'Seed Start......'
5.times {
  User.create(email: "#{Faker::Name.first_name.downcase}@blog.com", password: 123456, role: User.roles["user"], name: "#{Faker::Name.name}")
}

5.times {
  User.create(email: "#{Faker::Name.first_name.downcase}@blog.com", password: 123456, role: User.roles["admin"], name: "#{Faker::Name.name}")
}

User.pluck(:id).each do |user_id|
10.times {
    post = Post.create(
            title: Faker::Dessert.variety,
            description: Faker::Lorem.paragraph,
            user_id: user_id
          )
    5.times{
      Comment.create(
        body: Faker::Lorem.paragraph,
        post_id: post.id,
        user_id: user_id
      )
    }
  }
end
puts "Seed completed !!!!!!!!!"