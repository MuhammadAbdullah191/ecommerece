class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def add_product(product,action)
    print(action);
    print("product.id");
    print(product.id);
    current_item=line_items.find_by(product_id:product.id)
    if action=="+"
      if current_item
        if current_item.product.quantity > current_item.quantity
          current_item.increment(:quantity)
        end
        else
        current_item=line_items.build(product_id: product.id)
      end
      current_item
    else
      if current_item.quantity == 1
        current_item
      else
      current_item.decrement(:quantity)
      end
    end

  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

end
