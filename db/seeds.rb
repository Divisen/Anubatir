require 'faker'
require 'json'

# json files
file_user = "db/users.json"
users_serialized = File.read(file_user)
users = JSON.parse(users_serialized)

file_tender = "db/tenders.json"
tenders_serialized = File.read(file_tender)
tenders = JSON.parse(tenders_serialized)

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
  user1 = User.create(first_name:Faker::Name.first_name, last_name:Faker::Name.last_name, username:Faker::Internet.username, email: "#{users["entries"][i]["email"]}", password: "#{users["entries"][i]["password"]}", is_builder: "#{users["entries"][i]["is_builder"]}")
  avatar = users["entries"][i]["avatar"]
  file = URI.open("#{avatar}")
  user1.avatar.attach(io: file, filename: "avatar.jpg#{i}", content_type: 'image/jpg')

  if user1.is_builder == false
    budget = (1000000..9999999).to_a.sample
    tender1 = Tender.create(title: "#{tenders["entries"][i]["title"]}", description: "#{tenders["entries"][i]["description"]}",estimated_budget: budget, location: "#{tenders["entries"][i]["location"]}", nature_of_works: "#{tenders["entries"][i]["nature_of_works"]}", user_id: "#{user1.id}")
    k = 0
    countdown3 = tenders["entries"][i]["image"].count
    countdown3.times do
      image = tenders["entries"][i]["image"][k]
      file = URI.open("#{image}")
      tender1.images.attach(io: file, filename: "tender.jpg#{k}", content_type: 'image/jpg')
      k += 1
    end
  end

  # if user1.is_builder == true
  #   added_quote = (-4000..50000).to_a.sample
  #   Bid.create(quote: "#{tender1.estimated_budget + added_quote}", tender_id: "#{tender1.id}", user_id: "#{user1.id}")
  # end

  rating = (1..5).to_a.sample
  Testimonial.create(content: "#{testimonials["entries"][i]["content"]}", rating: rating, user_id: "#{user1.id}")
  i += 1
end

puts "users created"
puts "tenders created"
puts "bids created"
puts "testimonials added"
