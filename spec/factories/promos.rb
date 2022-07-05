# frozen_string_literal: true

FactoryBot.define do
  factory :promo do
    user
    code { 'DEVS1NC' }
    discount { 0.7 }
    valid_till { '1970-01-01 00:00:01' }
  end
end
