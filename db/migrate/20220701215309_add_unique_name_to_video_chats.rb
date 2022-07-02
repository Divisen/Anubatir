class AddUniqueNameToVideoChats < ActiveRecord::Migration[6.1]
  def change
    add_column :video_chats, :unique_name, :string
  end
end
