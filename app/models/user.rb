class MyValidator < ActiveModel::Validator
  def validate(record)
    unless record.phone =~ /^((\+92)?(0092)?(92)?(0)?)(3)([0-9]{9})$/;
      record.errors.add :phone, "number is invalid!"
    end
  end
end


class User < ApplicationRecord
  include ActiveModel::Validations
  validates_with MyValidator
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :name, presence: true, on: :create
  validates :city, presence: true, on: :create
  validates :street, presence: true, on: :create
  validates :zip, presence: true, on: :create
  #  validates :last_name, presence: true, on: :create

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
