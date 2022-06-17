class AddConstraintsToProduct < ActiveRecord::Migration[5.2]
  def change
    def change
      add_index :products, :name, :string, null: false
    end
  end
end
