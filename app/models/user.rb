class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :avatar
  has_many :products
  has_many :comments
  has_many :reviewed_comments, through: :comments, source: :product
  has_many :promos

  def to_s
    email
  end

  after_create do
    customer = Stripe::Customer.create(email:email)
    update(stripe_customer_id: customer.id)
  end
end
