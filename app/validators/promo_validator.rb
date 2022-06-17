# frozen_string_literal: true

class PromoValidator < ActiveModel::Validator
  def validate(record)
    return if record.code =~ /\A(?=.*[a-z])[a-z\d]+\Z/i && record.code == record.code.upcase

    record.errors.add :code, 'should only be capital and atleast one alphabet'
  end
end
