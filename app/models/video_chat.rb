class VideoChat < ApplicationRecord
  before_create :add_unique_name

  def add_unique_name
    unless self.unique_name.present?
      self.unique_name = (0...15).map { ('a'..'z').to_a[rand(26)] }.join
    end
  end
end
