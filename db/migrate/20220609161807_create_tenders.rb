class CreateTenders < ActiveRecord::Migration[6.1]
  def change
    create_table :tenders do |t|

      t.timestamps
    end
  end
end
