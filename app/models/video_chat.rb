class VideoChat < ApplicationRecord
  has_many :vloggers
  has_many :users, through: :vloggers
  before_create :add_unique_name

  def add_unique_name
    unless self.unique_name.present?
      self.unique_name = (0...15).map { ('a'..'z').to_a[rand(26)] }.join
    end
  end

  def self.create_private_video_chat(users, video_chat_name)
    single_video_chat = VideoChat.create(name: video_chat_name)
    users.each do |user|
      Vlogger.create(user_id: user.id, video_chat_id: single_video_chat.id)
    end
    single_video_chat
  end
end
