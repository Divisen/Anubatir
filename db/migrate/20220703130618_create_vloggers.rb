class CreateVloggers < ActiveRecord::Migration[6.1]
  def change
    create_table :vloggers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :video_chat, null: false, foreign_key: true

      t.timestamps
    end
  end
end
