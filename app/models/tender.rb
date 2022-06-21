class Tender < ApplicationRecord
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?
  belongs_to :user
  has_many :bids
  has_many_attached :images


  include PgSearch::Model
  pg_search_scope :global_search,
    against: [ :description, :nature_of_works, :title, :location],
    associated_against: {
      user: [ :username, :email ]
    },
    using: {
      tsearch: { prefix: true }
    }
end
