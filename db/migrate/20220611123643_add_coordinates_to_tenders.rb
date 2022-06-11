class AddCoordinatesToTenders < ActiveRecord::Migration[6.1]
  def change
    add_column :tenders, :latitude, :float
    add_column :tenders, :longitude, :float
  end
end
