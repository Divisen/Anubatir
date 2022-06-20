class AddMoreColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :company_name, :string
    add_column :users, :address, :string
    add_column :users, :about_me, :text
  end
end
