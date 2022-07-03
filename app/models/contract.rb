class Contract < ApplicationRecord
  has_many_attached :images
  belongs_to :user
  belongs_to :bid
end
