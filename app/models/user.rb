class User < ApplicationRecord
  has_many :tenders
  has_many :bids
  has_many :participants
  has_many :vloggers
  has_many :chatrooms, through: :participants
  has_many :video_chats, through: :vloggers
  has_many :messages
  has_many :contracts, through: :bids
  has_one_attached :avatar
  has_one_attached :logo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user) }
end
