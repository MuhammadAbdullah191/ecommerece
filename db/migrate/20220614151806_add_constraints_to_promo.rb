class AddConstraintsToPromo < ActiveRecord::Migration[5.2]
  def change
      add_index :promos, :code, unique: true
  end
end
