class Vlogger < ApplicationRecord
  belongs_to :user
  belongs_to :video_chat
end
