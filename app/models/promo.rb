class PromoValidator < ActiveModel::Validator
  def validate(record)
    unless record.code =~ /\A(?=.*[a-z])[a-z\d]+\Z/i;
      record.errors.add :code, "should only be alphanumeric!"
    end
  end
end

class Promo < ApplicationRecord
  include ActiveModel::Validations
  validates_with PromoValidator
  belongs_to :user
end
