class ImageValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :images, 'SHOULD BE ATTACHED ATLEAST 1' unless record.images.attached?
  end
end
