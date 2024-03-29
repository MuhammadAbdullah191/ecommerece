# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    product
    commenter { 'username' }
    body { 'this is test comment' }
  end
end
