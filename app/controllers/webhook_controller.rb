class WebhookController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    puts "Signature 1"
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, "whsec_hEgmS0Vrj805OpwP48OxrhgLJieGp8v0"

      )
    rescue JSON::ParserError => e
      status 400
      puts "Signature 2"
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      puts "Signature 3"
      p e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      p "testasdsaing cart"
      p @cart.destroy

      puts("check out successful")
      # @cart = Cart.create

      # session_with_expand = Stripe::Checkout::Session.retrieve({ id: session.id, expand: ["line_items"]})
      # session_with_expand.line_items.data.each do |line_item|
      #   product = Product.find_by(stripe_product_id: line_item.price.product)
      #   product.increment!(:sales_count)
      # end
    end

    render json: { message: 'success' }
  end
end
