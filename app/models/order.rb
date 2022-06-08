class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  def add_product(product,quantity)
    print("product.id");
    print(product.id);
    current_item = order_items.find_by(product_id: product.id)

    if current_item
      current_item.increment(:quantity)
    else
      current_item = order_items.new(product_id: product.id,price: product.price, quantity: quantity)
      p "i AM IN ORDER CONTROLELR"
      # current_item.price=
      # current_item.quantity=product.quantity
      p current_item
      current_item.save
    end
    current_item
  end

  def total_price
    order_items.to_a.sum {|item| item.total_price}
  end
end
