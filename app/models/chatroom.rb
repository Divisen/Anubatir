class Chatroom < ApplicationRecord
  has_many :messages
  has_many :participants
  has_many :users, through: :participants

  def self.create_private_chatroom(users, chatroom_name)
    single_chatroom = Chatroom.create(name: chatroom_name)
    users.each do |user|
      Participant.create(user_id: user.id, chatroom_id: single_chatroom.id)
    end
    single_chatroom
  end
end
