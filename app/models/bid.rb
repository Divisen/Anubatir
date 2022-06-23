class Bid < ApplicationRecord
  belongs_to :user
  belongs_to :tender
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :items, reject_if: :all_blank, allow_destroy: true
  validates :user, uniqueness: { scope: :tender }
end
