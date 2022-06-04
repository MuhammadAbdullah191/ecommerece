class CheckoutController < ApplicationController

  def create
    product=Product.find(params[:id])
    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        name: product.name,
        amount: 999,
        currency: 'usd',
        quantity: 1
      }
      ],
      mode: 'payment',
      success_url: "https://www.google.com/?client=safari",
      cancel_url: "https://www.google.com/?client=safari",
    })
  end

  respond_to do |format|
    format.js
  end


end
