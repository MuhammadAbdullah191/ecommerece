# frozen_string_literal: true
require 'faker'
FactoryBot.define do
  factory :user do
    name { Faker::Name.name  }
    email { Faker::Internet.email }
    password { '87tghjut' }
    city { 'Rawalpindi' }
    street { '1' }
    zip { '46000' }
    phone { '03349949490' }
  end
end
