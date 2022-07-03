class AddDurationToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :duration, :integer
  end
end
