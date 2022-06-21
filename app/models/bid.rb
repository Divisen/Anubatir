class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :tender

  # validates :user, uniqueness: { message: "should happen once per year" }, on: :create
end
