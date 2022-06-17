class AddUniquenessConstraintToPromo < ActiveRecord::Migration[5.2]
  def change
    add_index :promos, [:code, :discount], unique: true
  end
end
