# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :products, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviewed_comments, through: :comments, source: :product
  has_many :orders, dependent: :destroy
  has_one :promo, dependent: :destroy

  after_create :update_stripe_customer

  validates :name, presence: true, on: :create
  validates :city, presence: true, on: :create
  validates :street, presence: true, on: :create
  validates :zip, presence: true, on: :create
  validates :phone,
            format: { with: /\A((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})\z/,
                      message: 'number is invalid. Please enter again' }

  def to_s
    email
  end

  def update_stripe_customer
    customer = Stripe::Customer.create(email: email)
    update(stripe_customer_id: customer.id)
  end
end
