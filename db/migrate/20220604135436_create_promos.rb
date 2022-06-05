class CreatePromos < ActiveRecord::Migration[5.2]
  def change
    create_table :promos do |t|
      t.string :code
      t.float :discount
      t.datetime :valid_till, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
