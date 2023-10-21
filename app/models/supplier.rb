class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, :phone, presence: true
  validates :registration_number, uniqueness: true
  validates :registration_number, length: { is: 13 }
  validates :phone, format: { with: /\A[0-9]{11}\z/, message: "formato inválido" }
  has_many :product_models
end
