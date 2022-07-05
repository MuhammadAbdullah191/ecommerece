# frozen_string_literal: true
require 'faker'
FactoryBot.define do
  factory :line_item do
    product
    cart
    quantity { 5 }
  end
end
