# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    user
    name { Faker::Commerce.product_name }
    product_type { 'Quality product' }
    quantity { 5 }
    price { 600 }
    after(:build) do |product|
      product.images.attach(
        io: File.open(Rails.root.join('spec', 'support', 'assets','Unknown.jpeg')),
        filename: 'Unknown.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end

