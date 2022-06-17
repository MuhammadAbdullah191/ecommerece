class AddConstraintsToPromoDiscount < ActiveRecord::Migration[5.2]
  def up
    execute "ALTER TABLE promos ADD CONSTRAINT discount_check CHECK (discount > 0 AND discount < 1)"
  end

  def down
    execute "ALTER TABLE products DROP CONSTRAINT quantity_check"
  end
end
