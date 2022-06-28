# frozen_string_literal: true
require 'faker'
FactoryBot.define do
  factory :user do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    password { Faker::Alphanumeric.alpha(number: 8) }
    city { Faker::Address.city }
    street { '1' }
    zip { Faker::Address.zip_code }
    phone { '03349949490' }
  end
end
