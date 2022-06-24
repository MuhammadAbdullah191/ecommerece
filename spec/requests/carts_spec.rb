# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  describe 'GET /carts' do
    it 'works!' do
      get carts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST carts_path' do
    it 'creates new cart' do
      post carts_path
      expect(response).to have_http_status(:found)
    end
  end

  describe 'update cart_path' do
    it 'updates a cart' do
      cart = FactoryBot.create(:cart)
      put cart_path(id: cart.id)
      expect(response).to have_http_status(:found)
    end

    it 'cart is updates after creating line_item' do
      cart = FactoryBot.create(:cart)
      line_item = FactoryBot.create(:line_item, cart: cart)
      cart.reload
      expect(cart.line_items.count).to eq(1)
    end

    it 'delets users own items after login' do
      user = FactoryBot.create(:user, email: 'abd0@gmail.com')
      product = FactoryBot.create(:product, user: user)
      user.confirm
      sign_in user
      get authenticated_root_path
      expect(controller.current_user).to eq(user)
      cart = FactoryBot.create(:cart)
      line_item = FactoryBot.create(:line_item, cart: cart)
      line_item = FactoryBot.create(:line_item, cart: cart, product: product)

      expect { put cart_path(id: cart.id) }.to change { cart.line_items.count }.from(2).to(1)
    end
  end

  describe 'destroy cart_path' do
    it 'updates a cart' do
      cart = FactoryBot.create(:cart)
      delete cart_path(id: cart.id)
      expect(response).to have_http_status(:found)
    end
  end
end
