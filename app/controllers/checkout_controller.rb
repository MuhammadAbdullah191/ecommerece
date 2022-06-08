class CheckoutController < ApplicationController

  def create
    print("@cart.line_item")
    # p @cart.line_items
    # p @cart.line_items.collect {|item| item.to_builder.attributes!}
    # return 0
    @data=@cart.line_items.collect {|item| item.to_builder.attributes!}
    print("current user is");
    print(current_user.id);
    print(@data)
    if current_user.promo.present?
      p "promos are present"
      p current_user.promo.discount
      @data.each do |d|
        d["amount"]=d["amount"]*current_user.promo.discount
        d["amount"] = d["amount"].to_i
      end

    else
      p "promos are not present"
    end

    # print("@data[0][]")
    # @data[0]["amount"]=800
    # print(@data[0]["amount"])
    print(@data)
    # product=Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: @data ,
      allow_promotion_codes: true,
      mode: 'payment',
      success_url: success_url+"?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "https://www.google.com/?client=safari",
    })
  end

  respond_to do |format|
    format.js
  end

  def success

    p "in checkout"
    # p session
    p @cart.line_items.first.product_id
    session = Stripe::Checkout::Session.retrieve(params[:session_id])
    p "session"
    p session
    @count=0
    @user=User.find_by(stripe_customer_id: session.customer)
    p @user
    @order = Order.create(user_id: @user.id)

    @cart.line_items.each do|line_item|
      @product=Product.find(line_item.product_id)
      @order.add_product(@product,line_item.quantity)
    end

    p "in checkout"
    p @order
    decrementQuantity
    p "checking order"
    @cart.destroy
  end

  def decrementQuantity
    @cart.line_items.each do|line_item|
      @product=Product.find(line_item.product_id)
      @product.decrement(line_item.product_id ,line_item.quantity)
    end
    p "hello in decrement"
  end


end
