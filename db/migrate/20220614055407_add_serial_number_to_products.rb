class AddSerialNumberToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :serial_number, :string
  end
end
