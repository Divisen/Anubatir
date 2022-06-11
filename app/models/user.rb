class User < ApplicationRecord
  has_many :tenders
  has_many :bids
  has_many :contracts, through: :bids
  has_one_attached :avatar
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
