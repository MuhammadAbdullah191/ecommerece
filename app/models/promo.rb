# frozen_string_literal: true

class Promo < ApplicationRecord
  belongs_to :user

  validates :code, presence: true, length: { in: 4..10 }
  validates :discount, presence: true
  validates :valid_till, presence: true
  validates_with PromoValidator
end
