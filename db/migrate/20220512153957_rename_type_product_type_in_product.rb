# frozen_string_literal: true

class RenameTypeProductTypeInProduct < ActiveRecord::Migration[5.2]
  def up
    rename_column :products, :type, :product_type
  end

  def down
    rename_column :products, :product_type, :type
  end
end
