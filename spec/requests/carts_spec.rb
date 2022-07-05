# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Carts', type: :request do
  let(:cart) { create(:cart) }
  let(:line_item) { create(:line_item, cart: cart) }
  let(:test_line_item) {create(:line_item, cart: cart, product: product)}
  let(:user) { create(:user, email: 'abd0@gmail.com') }
  let(:product) {create(:product, user: user)}
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
      put cart_path(id: cart.id)
      expect(response).to have_http_status(:found)
    end

    it 'cart is updates after creating line_item' do
      line_item
      cart.reload
      expect(cart.line_items.count).to eq(1)
    end

    context 'if user signs in' do
      before do
        signed_in(user)
        line_item
        test_line_item
      end
      it 'delets users own items after login' do
        expect { put cart_path(id: cart.id) }.to change { cart.line_items.count }.from(2).to(1)
      end
    end

  end

  describe 'destroy cart_path' do
    it 'updates a cart' do
      delete cart_path(id: cart.id)
      expect(response).to have_http_status(:found)
    end
  end
  private

  def signed_in(user)
    user.confirm
    sign_in user
    get authenticated_root_path
  end
end
