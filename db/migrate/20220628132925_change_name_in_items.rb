class ChangeNameInItems < ActiveRecord::Migration[6.1]
  def change
    change_column :items, :name, :text
  end
end
