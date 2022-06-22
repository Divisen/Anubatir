class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :quantity
      t.string :unit
      t.integer :unit_rate
      t.integer :amount
      t.belongs_to :bid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
