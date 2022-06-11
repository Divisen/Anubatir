class AddColumnToBids < ActiveRecord::Migration[6.1]
  def change
    add_column :bids, :approved, :boolean
  end
end
