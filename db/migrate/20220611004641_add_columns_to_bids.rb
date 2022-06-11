class AddColumnsToBids < ActiveRecord::Migration[6.1]
  def change
    add_reference :bids, :tender, null: false, foreign_key: true
    add_reference :bids, :user, null: false, foreign_key: true
    add_column :bids, :quote, :float
  end
end
