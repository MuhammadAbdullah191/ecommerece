# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :type
      t.integer :quantity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
