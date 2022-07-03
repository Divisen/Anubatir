class VideoChat < ApplicationRecord
  has_many :vloggers
  has_many :users, through: :vloggers

  def self.create_private_video_chat(users, video_chat_name)
    single_video_chat = VideoChat.create(name: video_chat_name)
    users.each do |user|
      Vlogger.create(user_id: user.id, video_chat_id: single_video_chat.id)
    end
    single_video_chat
  end
end
