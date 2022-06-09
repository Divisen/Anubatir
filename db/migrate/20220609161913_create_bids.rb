class CreateBids < ActiveRecord::Migration[6.1]
  def change
    create_table :bids do |t|

      t.timestamps
    end
  end
end
