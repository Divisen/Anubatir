class AddNametoChatrooms < ActiveRecord::Migration[6.1]
  def change
    add_column :chatrooms, :name, :string
  end
end
