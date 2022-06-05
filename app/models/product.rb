class Product < ApplicationRecord
  before_destroy :not_referenced_by_any_line_item
  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :reviewers, through: :comments, source: :user
  has_many_attached :images
  has_many :line_items

  def not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, "Line items present")
      throw :abort
    end
  end
end
