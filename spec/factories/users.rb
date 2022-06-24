# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { 'John' }
    email { 'abdullah191@gmail.com' }
    password { '87tghjut' }
    city { 'Rawalpindi' }
    street { '1' }
    zip { '46000' }
    phone { '03349949490' }
  end
end
