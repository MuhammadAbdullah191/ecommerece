class AddConstraintsToProductsQuantity < ActiveRecord::Migration[5.2]
    def up
      execute "ALTER TABLE products ADD CONSTRAINT quantity_check CHECK (quantity > -1)"
    end

    def down
      execute "ALTER TABLE products DROP CONSTRAINT quantity_check"
    end
end
