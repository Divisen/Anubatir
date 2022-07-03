class AddDurationToItems < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :duration, :integer
  end
end
