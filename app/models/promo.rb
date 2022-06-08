class PromoValidator < ActiveModel::Validator
  def validate(record)
    unless record.code =~ /\A(?=.*[a-z])[a-z\d]+\Z/i && record.code==record.code.upcase;
      record.errors.add :code, "should only be capital and atleast one alphabet"
    end
  end
end

class Promo < ApplicationRecord
  include ActiveModel::Validations
  validates :code, presence: true , length: { in: 4..10 }
  validates :discount, presence: true
  validates :valid_till, presence: true
  # validates :code, length: {minimun: 4,  maximum: 10, too_long: "%{count} characters is the maximum allowed" }
  validates_with PromoValidator

  belongs_to :user
end
