class AddColumnsToContracts < ActiveRecord::Migration[6.1]
  def change
    add_reference :contracts, :bid, null: false, foreign_key: true
    add_column :contracts, :has_client_signed, :boolean
    add_column :contracts, :has_builder_signed, :boolean, default: true
    add_column :contracts, :completed, :boolean
    add_column :contracts, :duration, :integer
  end
end
