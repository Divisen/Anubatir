require 'faker'
require 'json'

# JSON FILES

# Users
file_user = "db/users.json"
users_serialized = File.read(file_user)
users = JSON.parse(users_serialized)

# Tenders
file_tender = "db/tenders.json"
tenders_serialized = File.read(file_tender)
tenders = JSON.parse(tenders_serialized)

# Testimonials
filepath = "db/testimonials.json"
testimonials_serialized = File.read(filepath)
testimonials = JSON.parse(testimonials_serialized)

# Clearing database
puts "clearing database"
Contract.destroy_all
Bid.destroy_all
Tender.destroy_all
Testimonial.destroy_all
Vlogger.destroy_all
VideoChat.destroy_all
Participant.destroy_all
Message.destroy_all
Chatroom.destroy_all
User.destroy_all

# Creating database using faker and json files
# (REFACTORED) This code allows us to just insert new entries in the json files without bothering with changing the number of the times the loop needs to repeat itself
puts "creating users"
countdown = users["entries"].count / 2
i = 0
j = 1
countdown.times do
  user1 = User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, username: Faker::Internet.username, address:Faker::Address.street_address, email: "#{users["entries"][i]["email"]}", password: "#{users["entries"][i]["password"]}", is_builder: "#{users["entries"][i]["is_builder"]}", about_me: "#{users["entries"][i]["about_me"]}")
  avatar1 = users["entries"][i]["avatar"]
  file1 = URI.open("#{avatar1}")
  user1.avatar.attach(io: file1, filename: "avatar.jpg#{i}", content_type: 'image/jpg')
  user2 = User.create(company_name:Faker::Company.name, username:Faker::Internet.username, address:Faker::Address.street_address, grade_of_contractor: "#{('A'..'E').to_a.sample}",email: "#{users["entries"][j]["email"]}", password: "#{users["entries"][j]["password"]}", is_builder: "#{users["entries"][j]["is_builder"]}", admin: "#{users["entries"][j]["admin"]}", about_me: "#{users["entries"][j]["about_me"]}")
  avatar2 = users["entries"][j]["avatar"]
  logo = users["entries"][j]["logo"]
  file2 = URI.open("#{avatar2}")
  file_logo = URI.open("#{logo}")
  user2.avatar.attach(io: file2, filename: "avatar.jpg#{j}", content_type: 'image/jpg')
  user2.logo.attach(io: file_logo, filename: "logo.jpg#{j}", content_type: 'image/jpg')

  budget = (1000000..9999999).to_a.sample
  tender1 = Tender.create(title: "#{tenders["entries"][i]["title"]}", description: "#{tenders["entries"][i]["description"]}",estimated_budget: budget, location: "#{tenders["entries"][i]["location"]}", nature_of_works: "#{tenders["entries"][i]["nature_of_works"]}", user_id: "#{user1.id}")
  tender2 = Tender.create(title: "#{tenders["entries"][j]["title"]}", description: "#{tenders["entries"][j]["description"]}",estimated_budget: budget, location: "#{tenders["entries"][j]["location"]}", nature_of_works: "#{tenders["entries"][j]["nature_of_works"]}", user_id: "#{user1.id}")
  k = 0
  countdown3 = tenders["entries"][i]["image"].count
  countdown3.times do
    image1 = tenders["entries"][i]["image"][k]
    file1 = URI.open("#{image1}")
    tender1.images.attach(io: file1, filename: "tender#{k}.jpg", content_type: 'image/jpg')
    k += 1
  end
  l = 0
  countdown4 = tenders["entries"][j]["image"].count
  countdown4.times do
    image2 = tenders["entries"][j]["image"][l]
    file2 = URI.open("#{image2}")
    tender2.images.attach(io: file2, filename: "tenderz#{l}.jpg", content_type: 'image/jpg')
    l += 1
  end
  added_quote = (-4000..50000).to_a.sample
  Bid.create(quote: "#{tender1.estimated_budget + added_quote}", tender_id: "#{tender1.id}", user_id: "#{user2.id}")
  Bid.create(quote: "#{tender1.estimated_budget + added_quote}", tender_id: "#{tender2.id}", user_id: "#{user2.id}")
  rating = (1..5).to_a.sample
  Testimonial.create(content: "#{testimonials["entries"][i]["content"]}", rating: rating, user_id: "#{user1.id}")
  Testimonial.create(content: "#{testimonials["entries"][j]["content"]}", rating: rating, user_id: "#{user2.id}")
  i += 2
  j += 2
end

puts "users created"
puts "tenders created"
puts "bids created"
puts "testimonials added"
