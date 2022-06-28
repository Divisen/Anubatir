class AddRejectedToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :rejected, :boolean
  end
end
