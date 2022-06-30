class User < ApplicationRecord
  has_many :tenders
  has_many :bids
  has_many :participants
  has_many :messages
  has_many :contracts, through: :bids
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user) }
end
