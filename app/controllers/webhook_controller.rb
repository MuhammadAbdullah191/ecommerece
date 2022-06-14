# frozen_string_literal: true

class WebhookController < ApplicationController
  # before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def create
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, 'whsec_hEgmS0Vrj805OpwP48OxrhgLJieGp8v0'
      )
    rescue JSON::ParserError => e
      status 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      Rails.logger.debug e
      return
    end

    # Handle the event
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      Rails.logger.debug 'testasdsaing cart'

      Rails.logger.debug('check out successful')
    end

    render json: { message: 'success' }
  end
end
