class AddTitleToTenders < ActiveRecord::Migration[6.1]
  def change
    add_column :tenders, :title, :string
  end
end
