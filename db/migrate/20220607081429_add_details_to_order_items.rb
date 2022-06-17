# frozen_string_literal: true

class AddDetailsToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :quantity, :integer
    add_column :order_items, :price, :integer
  end
end
