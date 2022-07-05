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
        payload, sig_header, 'whsec_cc17bdb359c7f406bd7e8dc85f6419c28ab102880ef96d69432a6ddf040c378a'
      )
    rescue JSON::ParserError
      status 400
      return
    rescue Stripe::SignatureVerificationError
      return
    end
    case event.type
    when 'checkout.session.completed'
      session = event.data.object
      Rails.logger.debug session
    end
    render json: { message: 'success' }
  end
end
