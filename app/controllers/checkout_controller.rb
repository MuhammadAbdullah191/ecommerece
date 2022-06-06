class CheckoutController < ApplicationController

  def create
    print("@cart.line_item")
    # p @cart.line_items
    # p @cart.line_items.collect {|item| item.to_builder.attributes!}
    # return 0
    # @data=@cart.line_items.collect {|item| item.to_builder.attributes!}
    # print(@data)
    # product=Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      customer: current_user.stripe_customer_id,
      payment_method_types: ['card'],
      line_items: [{"name"=>"Watch", "amount"=>899, "quantity"=>1, "currency"=>"usd"}, {"name"=>"Shoes", "amount"=>1000, "quantity"=>1, "currency"=>"usd"}] ,
      mode: 'payment',
      success_url: success_url,
      cancel_url: "https://www.google.com/?client=safari",
    })
  end

  respond_to do |format|
    format.js
  end

  def success
    @cart.destroy
  end


end
