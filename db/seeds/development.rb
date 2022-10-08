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

  def seed_ahoy
    Ahoy.geocode = false
    request = OpenStruct.new(
      params: {},
      referer: 'http://example.com',
      remote_ip: '0.0.0.0',
      user_agent: 'Internet Explorer, lol can you imagine?',
      original_url: 'rails'
    )
  
    visit_properties = Ahoy::VisitProperties.new(request, api: nil)
    properties = visit_properties.generate.select { |_, v| v }
  
    example_visit = Ahoy::Visit.create!(properties.merge(
                                          visit_token: SecureRandom.uuid,
                                          visitor_token: SecureRandom.uuid
                                        ))
  
    2.months.ago.to_date.upto(Date.today) do |date|
      Post.all.each do |post|
        rand(1..5).times do |_x|
          Ahoy::Event.create!(name: 'Viewed Post',
                              visit: example_visit,
                              properties: { post_id: post.id },
                              time: date.to_time + rand(0..23).hours + rand(0..59).minutes)
        end
      end
    end
  end
  seed_ahoy
end
puts "-------------"
puts "-------------"
puts "-------------"

puts "Real time is #{elapsed.real}"

puts "-------------"
puts "-------------"
puts "-------------"