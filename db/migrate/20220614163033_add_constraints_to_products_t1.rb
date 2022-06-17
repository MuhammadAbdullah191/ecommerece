class AddConstraintsToProductsT1 < ActiveRecord::Migration[5.2]
    def up
      execute "ALTER TABLE products ADD CONSTRAINT price_check CHECK (price > 500)"
    end

    def down
      execute "ALTER TABLE products DROP CONSTRAINT price_check"
    end
end
