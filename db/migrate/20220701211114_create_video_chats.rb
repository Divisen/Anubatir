class CreateVideoChats < ActiveRecord::Migration[6.1]
  def change
    create_table :video_chats do |t|
      t.string :name
      t.integer :room_sid

      t.timestamps
    end
  end
end
