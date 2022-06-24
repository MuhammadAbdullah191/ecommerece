# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    user
    name { 'testProduct' }
    product_type { 'Quality product' }
    quantity { 5 }
    price { 600 }
  end
end
