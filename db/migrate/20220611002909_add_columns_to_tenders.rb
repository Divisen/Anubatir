class AddColumnsToTenders < ActiveRecord::Migration[6.1]
  def change
    add_column :tenders, :estimated_budget, :integer
    add_column :tenders, :description, :text
    add_column :tenders, :nature_of_works, :string
    add_column :tenders, :location, :string
    add_column :tenders, :specifications, :text
    add_column :tenders, :estimated_start_date, :date
    add_column :tenders, :estimated_end_date, :date
    add_reference :tenders, :user, null: false, foreign_key: true
  end
end
