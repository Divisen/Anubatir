require 'faker'
require 'json'

# json files
file_user = "db/users.json"
users_serialized = File.read(file_user)
users = JSON.parse(users_serialized)

filepath = "db/testimonials.json"
testimonials_serialized = File.read(filepath)
testimonials = JSON.parse(testimonials_serialized)

# Clearing database
puts "clearing database"
Contract.destroy_all
Bid.destroy_all
Tender.destroy_all
Testimonial.destroy_all
User.destroy_all

# Creating database using faker and json files
# (REFACTORED) This code allows us to just insert new entries in the json files without bothering with changing the number of the times the loop needs to repeat itself
puts "creating users"
countdown = users["entries"].count
i = 0
countdown.times do
  user1 = User.create(first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, username:Faker::Internet.username, email: "#{users["entries"][i]["email"]}", password: "#{users["entries"][i]["password"]}")
  avatar = users["entries"][i]["avatar"]
  file = URI.open("#{avatar}")
  user1.avatar.attach(io: file, filename: "avatar.jpg#{i}", content_type: 'image/jpg')

  rating = (1..5).to_a.sample
  Testimonial.create(content: "#{testimonials["entries"][i]["content"]}", rating: rating, user_id: "#{user1.id}")
  i += 1
end

puts "users created"
puts "testimonials added"

