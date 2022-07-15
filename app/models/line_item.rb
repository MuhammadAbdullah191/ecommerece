# frozen_string_literal: true

class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  validates :quantity, presence: true

  def total_price
    product.price.to_i * quantity.to_i
  end

  def to_builder
    @product = Product.find(product_id)
    Jbuilder.new do |line_item|
      line_item.name @product.name
      line_item.amount @product.price
      line_item.quantity quantity
      line_item.currency 'usd'
    end
  end

  def to_builders
    @product = Product.find(product_id)
    if @product.images.attached?
      @image=@product.images.first.service_url
      Jbuilder.new do |line_item|
        line_item.id @product.id
        line_item.name @product.name
        line_item.amount @product.price
        line_item.quantity quantity
        line_item.total @product.quantity
        line_item.currency 'usd'
        line_item.url @image
      end
    else
      Jbuilder.new do |line_item|
        line_item.id @product.id
        line_item.name @product.name
        line_item.amount @product.price
        line_item.quantity quantity
        line_item.currency 'usd'
        line_item.url nil
      end
    end

  end
end
