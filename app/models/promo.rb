# frozen_string_literal: true

class Promo < ApplicationRecord
  belongs_to :user

  validates :code, presence: true, length: { in: 4..10 }
  validates :discount, presence: true
  validates :valid_till, presence: true
  validate :validate_promo

  def validate_promo
    return if code =~ /\A(?=.*[a-z])[a-z\d]+\Z/i && code == code.upcase

    errors.add :code, 'should only be capital and atleast one alphabet'
  end
end
